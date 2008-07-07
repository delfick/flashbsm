import settings
import simplejson
import cjson
import os
import sys
infoObject = settings.getInfoObject()

def writeJSONToFile():
	print "hello there"
	xml_file = os.path.abspath(__file__)
	xml_file = os.path.dirname(xml_file)
	xml_file = os.path.join(xml_file, "tester.json")
	testerXML = open(xml_file, 'w')
	simplejson.dump(infoObject, testerXML, indent=4)
	
def getTheInfo():
	updateContext()
	return infoObject
	
def updateContext():
	settings.updateContext()
	
def changeSetting(params):
	return settings.changeSetting(params)
	
def renewValue(params):
	return settings.renewValue(params)
	
	
services = {
	'writeToFile' : writeJSONToFile,
	'getInfo': getTheInfo,
	'updateContext': updateContext,
	'settingsChange': changeSetting,
	'renewValue': renewValue
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
