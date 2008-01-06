#!/usr/bin/env python
import compizconfig
context = compizconfig.Context()

def echo(data):
	return data

def getPluginList():
	data = list(context.Plugins)
	return data

def getCategories():
	return list(context.Categories)

def getCategoryList(categ):
	return list([p.ShortDesc for p in context.Categories[categ]])

def getCategoryListSize(categ):
	return len(list([p.ShortDesc for p in context.Categories[categ]]))

def getActivePluginList():
	data = context.Plugins['core'].Display['active_plugins'].Value
	return data

services = {
    'echo': echo,
	'getPluginList.getPluginList': getPluginList,
	'getActivePluginList.getActivePluginList': getActivePluginList,
	'getCategoryList.getCategoryList' : getCategoryList,
	'getCategories.getCategories' : getCategories,
	'getCategoryListSize.getCategoryListSize' : getCategoryListSize,
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
