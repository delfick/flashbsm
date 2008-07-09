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
	xml_file = os.path.join(xml_file, "assets/json/allSettings.txt")
	testerXML = open(xml_file, 'w')
	simplejson.dump(infoObject, testerXML, indent=4)
	
if __name__ == '__main__':
    writeJSONToFile()
