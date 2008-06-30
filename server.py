#!/usr/bin/env python
import compizconfig
context = compizconfig.Context()

def CatSortCompare(v1, v2):
    if v1 == v2:
        return cmp(v1, v2)
    if context.Plugins['core'].Category == v1:
        return cmp('', v2 or 'zzzzzzzz')
    if context.Plugins['core'].Category == v2:
        return cmp(v1 or 'zzzzzzz', '')
    return cmp(v1 or 'zzzzzzzz', v2 or 'zzzzzzzz')

def FirstItemSortCompare(sg1, sg2):
    return cmp(sg1[0], sg2[0])
    
def PluginSortCompare(p1, p2):
    return cmp(p1.ShortDesc, p2.ShortDesc)
    
def SettingSortCompare(v1, v2):
    return cmp(v1.Plugin.Ranking[v1.Name], v2.Plugin.Ranking[v2.Name])
    
def fileExists(f):
     try:
         file = open(f)
     except IOError:
         exists = 0
     else:
         exists = 1
     return exists
    
categories = []
    
for categ in list(sorted(context.Categories, CatSortCompare)):
	if categ is '':
		categ = 'Unknown'
	categories.append(categ)
	
plugins = list(context.Plugins)

categInfo = []
pluginInfo = []
categInfo.append(dict((k, v+1) for (v, k) in enumerate(categories)))
categInfo[0]["allGroups"] = list(categories)
categInfo[0]["activePlugins"] = list(context.Plugins['core'].Display['active_plugins'].Value)

	
for categ in sorted(context.Categories, CatSortCompare):
	allPlugins = {}
	thePlugins = []

	for plugin in context.Categories[categ]:
		thePlugins.append({"ShortDesc" : plugin.ShortDesc, "Name" : plugin.Name, "LongDesc" : plugin.LongDesc, "isEnabled" : plugin.Enabled, "Categ" : categ, "hasIcon" : fileExists('assets/icons/plugin-'+plugin.Name + '.png')})
	
	allPlugins["plugins"] = thePlugins
	allPlugins["allPlugins"] = list(p.ShortDesc for p in context.Categories[categ])
	pluginInfo.append(allPlugins);
	
def getPluginInfo():
	return pluginInfo
	
def getCategInfo():
	return categInfo
	
def getStatus(plugin):
	return context.Plugins[plugin[0]].Enabled
	
def getSettings():
	allSettingsHolder = {}
	for nextPlugin in context.Plugins:
		settings = []
		groupsSorted = sorted(context.Plugins[nextPlugin].Groups.items(), FirstItemSortCompare)
		for name, group in groupsSorted:
			if name is '':
				name = 'General'
			subGroupsSorted = sorted(group.items(), FirstItemSortCompare)
			theData = []
			for subGroupName, subGroup in subGroupsSorted:
				subData = []
				theSettings = sum((v.values() for v in [subGroup.Display]+[subGroup.Screens[0]]), [])
				theSettings = sorted(theSettings, SettingSortCompare)
				for setting in theSettings:
					subData.append({"Type" : setting.Type, "ShortDesc" : setting.ShortDesc, "info" : setting.Info, "Value" : setting.Value})
				theData.append({"label" : subGroupName, "data" : subData})		
			settings.append({"label" : name, "data" : theData} )
		allSettingsHolder[nextPlugin] = settings
	return allSettingsHolder
	
def enableDisablePlugin(theParams) :
	# theParams is [plugin, status]
	plugin = theParams[0]
	status = theParams[1]	
	if context.Plugins[plugin].Enabled == status:
		if status == True:
			context.Plugins[plugin].Enabled = False
		else:
			context.Plugins[plugin].Enabled = True
		if context.Plugins[plugin].Enabled == status:
			return "failed"
		else:
			return "succeeded"
	else:
		return "wrongStatus"

services = {
	'getPluginInfo': getPluginInfo,
	'getCategInfo': getCategInfo,
	'getSettings' : getSettings,
	'enableDisablePlugin' : enableDisablePlugin,
	'getStatus' : getStatus
}
    
if __name__ == '__main__':
    from pyamf.remoting.wsgigateway import WSGIGateway
    from wsgiref import simple_server

    gw = WSGIGateway(services)

    httpd = simple_server.WSGIServer(
        ('localhost', 8000),
        simple_server.WSGIRequestHandler,
    )

    httpd.set_app(gw)

    print "Running Hello World AMF gateway on http://localhost:8000"

    httpd.serve_forever()

proc = os.popen("""ps axo "%p,%a" | grep "server.py" | grep -v grep|cut -d',' -f1""").read()
print proc
procs = proc.split('\n')
if len(procs) > 2:
	print "server already started"
	import sys
	sys.exit(1)
else:
	print "no server yet"
    
class GroupPage(Page):
    def __init__(self, name, group, filter=None):
        Page.__init__(self)

        self.subGroupAreas = []

        if (group.has_key('')):
            sga = SubGroupArea('', group[''], filter)
            if not sga.Empty:
                self.SetContainer.pack_start(sga.Widget, False, False)
                self.Empty = False
                self.subGroupAreas = self.subGroupAreas + [sga]

        subGroupsSorted = sorted(group.keys(), cmp)
        for subGroup in subGroupsSorted:
            if not subGroup == '':
                sga = SubGroupArea(subGroup, group[subGroup], filter)
                if not sga.Empty:
                    self.SetContainer.pack_start(sga.Widget, False, False)
                    self.Empty = False
                    self.subGroupAreas = self.subGroupAreas + [sga]
