import compizconfig
context = compizconfig.Context()

def getInfoObject():
    InfoObject = []
    for category in sorted(context.Categories, CatSortCompare):
        nextCateg = {}
        nextCateg["Name"] = category
        nextCateg["Plugins"] = []
        InfoObject.append(nextCateg)
        for plugin in sorted(context.Categories[category], PluginSortCompare):
            nextPlugin = getPluginInfo(plugin)
            nextCateg["Plugins"].append(nextPlugin)
    return InfoObject
            
def getPluginInfo(plugin):
    infoObject = {}
    infoObject["Name"] = plugin.Name
    infoObject["ShortDesc"] = plugin.ShortDesc
    infoObject["LongDesc"] = plugin.LongDesc
    infoObject["Enabled"] = plugin.Enabled
    infoObject["Features"] = plugin.Features
    infoObject["Ranking"] = plugin.Ranking
    infoObject["Groups"] = []
    infoObject["HasIcon"] = fileExists('assets/icons/plugin-'+plugin.Name + '.png')
    for name, group in sorted(plugin.Groups.items(), FirstItemSortCompare):
        nextGroup = {}
        if name == '':
            nextGroup["Name"] = "General"
        else:
            nextGroup["Name"] = name
        nextGroup["SubGroups"] = []
        infoObject["Groups"].append(nextGroup)
        for subGroupName, subGroup in sorted(group.items(), FirstItemSortCompare):
            nextSubGroup = {}
            nextSubGroup["Name"] = subGroupName
            nextSubGroup["Settings"] = []
            nextGroup["SubGroups"].append(nextSubGroup)
            theSettings = sum((v.values() for v in [subGroup.Display]+[subGroup.Screens[0]]), [])
            for setting in sorted(theSettings, SettingSortCompare):
                nextSetting = getSettingInfo(setting)
                nextSubGroup["Settings"].append(nextSetting)
    return infoObject
        
def getSettingInfo(setting):
    infoObject = {}
    infoObject["Name"] = setting.Name
    infoObject["ShortDesc"] = setting.ShortDesc
    infoObject["LongDesc"] = setting.LongDesc
    infoObject["Type"] = setting.Type
    infoObject["Hints"] = setting.Hints
    if setting.Type == "List":
        theInfo = {}
        theInfo["ListType"] = setting.Info[0]
        theInfo["ListInfo"] = list(setting.Info[1])
        infoObject["Info"] = theInfo
    else:
        infoObject["Info"] = list(setting.Info)
    infoObject["Value"] = setting.Value
    infoObject["Default"] = setting.DefaultValue
    return infoObject
    
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
         exists = False
     else:
         exists = True
     return exists
