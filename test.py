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
				if setting.Type is "List":
					print setting.Info
			theData.append({"label" : subGroupName, "data" : subData})		
		settings.append({"label" : name, "data" : theData} )
	allSettingsHolder[nextPlugin] = settings
