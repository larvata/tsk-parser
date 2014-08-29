TskParser = require './src/TskParser.js'

ooo={}

loaded=(obj)->
	# console.log obj
	console.log obj.dieResults.length
	console.log obj.dieResults[85]

parser=new TskParser()
parser.readFile('test/001.QR2352-D5U278-CP-1',loaded)

setInterval ()->
	return
,1000
