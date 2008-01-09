#!/usr/bin/env python
import compizconfig
context = compizconfig.Context()
information = []
for categ in context.Categories:
	for plugin in context.Categories[categ]:
		information.append([[plugin.Name], [categ], [plugin.ShortDesc], [plugin.LongDesc]])
	
categories = list(context.Categories)

plugins = list(context.Plugins)

pl_categories = []
for categ in context.Categories:
	pl_categories.append(list([p.ShortDesc for p in context.Categories[categ]]))
	
print(pl_categories[1])

def echo(data):
	return data

def getNumberOfPlugins():
	return len(plugins)

def getPluginData(plugin):
	return information[plugin]

def getCategories():
	return categories

def getCategoryList(categ):
	return pl_categories[int(categ)]

def getActivePluginList():
	data = context.Plugins['core'].Display['active_plugins'].Value
	return data
	
services = {
    'echo': echo,
	'getNumberOfPlugins.getNumberOfPlugins': getNumberOfPlugins,
	'getPluginData.getPluginData': getPluginData,
	'getActivePluginList.getActivePluginList': getActivePluginList,
	'getCategoryList.getCategoryList' : getCategoryList,
	'getCategories.getCategories' : getCategories,
	'echo.echo': echo
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
