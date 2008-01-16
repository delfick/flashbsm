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
    
pluginNames = []
pluginIcons = []
pluginDescs = []
for categ in sorted(context.Categories, CatSortCompare):
	for plugin in context.Categories[categ]:
		pluginNames.append([plugin.ShortDesc])
		pluginIcons.append([plugin.Name])
		pluginDescs.append([plugin.LongDesc])
		

	
categories = list(sorted(context.Categories, CatSortCompare))

plugins = list(context.Plugins)

pl_categories = []
for categ in sorted(context.Categories, CatSortCompare):
	pl_categories.append(list([p.ShortDesc for p in context.Categories[categ]]))
	
def getPluginNames():
	return pluginNames
	
def getPluginIconNames():
	return pluginIcons
	
def getPluginDescs():
	return pluginDescs
	
def getNumberOfPlugins():
	return len(plugins)

def getCategories():
	return categories

def getCategoryList(categ):
	return pl_categories[int(categ)]

def getActivePluginList():
	data = context.Plugins['core'].Display['active_plugins'].Value
	return data
	
def enableDisablePlugin(plugin, status) :
	if context.Plugins[plugin[0].Enabled == status:
		return "wrongStatus"
	else
		if status == True:
			context.Plugins[plugin[0]].Enabled = False
			return context.Plugins[plugin[0]].Enabled
		else:
			context.Plugins[plugin[0]].Enabled = True
			return context.Plugins[plugin[0]].Enabled

services = {
	'getInfo.getNumberOfPlugins': getNumberOfPlugins,
	'getInfo.getPluginNames' : getPluginNames,
	'getInfo.getPluginIconNames' : getPluginIconNames,
	'getInfo.getPluginDescs' : getPluginDescs,
	'getInfo.getActivePluginList': getActivePluginList,
	'getInfo.getCategoryList' : getCategoryList,
	'getInfo.getCategories' : getCategories,
	'getInfo.enableDisablePlugin' : enableDisablePlugin
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
