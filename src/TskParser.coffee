BinaryReader = require './BinaryReader'
Entity = require './TskEntity'
fs = require 'fs'


LoadMapFileHeader=(br)->
	header=new Entity.MapFileHeader()
	# Map File Header Start

	# Wafer Testing Setup Data
	header.operatorName =br.readAsString(20)
	header.deviceName = br.readAsString(16)
	header.waferSize = br.readAsInt(2)
	header.machineNo = br.readAsInt(2)
	header.indexSizeX = br.readAsInt(4)
	header.indexSizeY = br.readAsInt(4)
	header.standardOrientationFlatDirection = br.readAsInt(2)
	header.finalEditingMachineType  = br.readAsInt(1)

	# Map Version
	# 0:Normal
	# 1: 250,000 Chilps
	# 2: 256 Multi-sites
	# 3: 256 Multi-sites (without extended header information)
	# 4: 1024 category
	header.mapVersion=br.readAsInt(1)

	header.mapDataAreaRowSize=br.readAsInt(2)
	header.mapDataAreaLineSize=br.readAsInt(2)

	# Map Data Form Group Management
	header.mapDataForm=br.readAsInt(4)

	# Wafer Specific Data
	header.waferId=br.readAsString(21)
	header.numberOfProbing=br.readAsInt(1)
	header.lotNo=br.readAsString(18)
	header.cassetteNo=br.readAsInt(2)
	header.slotNo=br.readAsInt(2)

	# Wafer Probing Coordinate System Data
	header.xCoordinatesIncreaseDirection=br.readAsInt(1)
	header.yCoordinatesIncreaseDirection=br.readAsInt(1)
	header.referenceDieSettingProcedures=br.readAsInt(1)
	header.reserved=br.readAsInt(1)
	header.targetDiePositionX=br.readAsInt(4)
	header.targetDiePositionY=br.readAsInt(4)
	header.referenceDieCoordinatorX=br.readAsInt(2)
	header.referenceDieCoordinatorY=br.readAsInt(2)
	header.probingStartPosition=br.readAsInt(1)
	header.probingDirection=br.readAsInt(1)
	header.reserved=br.readAsInt(2)
	header.distanceXtoWaferCenterDieOrigin=br.readAsInt(4)
	header.distanceYtoWaferCenterDieOrigin=br.readAsInt(4)
	header.coordinatorXofWaferCenterDie=br.readAsInt(4)
	header.coordinatorYofWaferCenterDie=br.readAsInt(4)

	# Inforamtion Per Die
	header.firstDieCoordinatorX=br.readAsInt(4)
	header.firstDieCoordinatorY=br.readAsInt(4)

	# Wafer Test Start Time Data
	header.startYear=br.readAsString(2)
	header.startMonth=br.readAsString(2)
	header.startDay=br.readAsString(2)
	header.startHour=br.readAsString(2)
	header.startMinute=br.readAsString(2)
	header.reserved=br.readAsBytes(2)

	# Wafer Test End Time Data
	header.endYear=br.readAsString(2)
	header.endMonth=br.readAsString(2)
	header.endDay=br.readAsString(2)
	header.endHour=br.readAsString(2)
	header.endMinute=br.readAsString(2)
	header.reserved=br.readAsBytes(2)

	# Wafer Loading Time Data
	header.loadYear=br.readAsString(2)
	header.loadMonth=br.readAsString(2)
	header.loadDay=br.readAsString(2)
	header.loadHour=br.readAsString(2)
	header.loadMinute=br.readAsString(2)
	header.reserved=br.readAsBytes(2)

	# Wafer Unloading Time Data
	header.unloadYear=br.readAsString(2)
	header.unloadMonth=br.readAsString(2)
	header.unloadDay=br.readAsString(2)
	header.unloadHour=br.readAsString(2)
	header.unloadMinute=br.readAsString(2)
	header.reserved=br.readAsBytes(2)

	# Vega
	header.vegaMachineNo=br.readAsString(4)
	header.vegaMachineNo2=br.readAsString(4)

	header.sepcialCharacters=br.readAsString(4)

	# Testing Result
	header.testingEndInformation=br.readAsInt(1)
	header.reserved=br.readAsBytes(1)
	header.totalTestedDice=br.readAsInt(2)
	header.totalPassDice=br.readAsInt(2)
	header.totalFailDice=br.readAsInt(2)

	# Test Die Inforamtion Address
	header.testDieInformationAddress=br.readAsInt(4)


	header.numberOfLineCategoryData=br.readAsInt(4)
	header.linCategoryAddress=br.readAsInt(4)

	# Extended Map Inforamtion
	header.mapFileConfiguration=new Entity.MapFileConfiguration(br.readAsBit(2))
	header.maxMultiSite=br.readAsInt(2)
	header.maxCategories=br.readAsInt(2)
	header.reserved=br.readAsBytes(2)
	# Map File Header End

	return header




LoadTestResults=(br,dieCount)->
	results=[]
	for i in [0...dieCount]
		die=new Entity.TestResultPerDie()

		word=br.readAsInt(2)
		die.dieTestResult = word>>14
		die.marking= (word>>13)&1
		die.failMarkInspection=(word>>12)&1
		die.reProbingResult=(word>>10)&3
		die.needleMarkInspectionResult=(word>>9)&1
		die.dieCoordinatorValueX=word&511

		word=br.readAsInt(2)
		die.dieProperty=word>>14
		die.needleMarkInspectionExecutionDieSelection=(word>>13)&1
		die.samplingDie=(word>>12)&1
		die.codeBitOfCorrdinatorValueX=(word>11)&1
		die.codeBitOfCorrdinatorValueY=(word>>10)&1
		die.dummyData=(word>>9)&1
		die.dieCoordinatorVauleY=word&511

		word=br.readAsInt(2)
		die.measurementFinish=(word>>15)&1
		die.rejectChipFlag=(word>>14)&1
		die.testExecutionSite=(word>>8)&63
		die.blockAreaJudegmentFuntion=(word>>6)&3
		die.categoryData=word&63

		results.push die
	return results





module.exports = class TskParser
	constructor: (filePath,callback) ->

	readFile: (filePath,callback)->
		fs.readFile filePath,(err,data)->
			br=new BinaryReader(data)

			@mapFile=new Entity.TskMapFile()

			@mapFile.header=LoadMapFileHeader(br)

			switch @mapFile.header.mapVersion
				when 0
					# header
					# test result
					# line category
					break

				when 1
					# header
					# extended header
					# test result
					# 250,000 test result
					# 250,000 extended test result
					break
				when 2
					# header
					# test result
					# line category
					# extended header
					# extended test result
					# extended line category
					br.goto(@mapFile.header.testDieInformationAddress)
					dieCount=@mapFile.header.mapDataAreaRowSize*@mapFile.header.mapDataAreaLineSize
					@mapFile.dieResults=LoadTestResults(br,dieCount)

					if @mapFile.header.mapFileConfiguration.extensionHeaderInformation
						@extensionHeader=new Entity.ExtensionHeaderInformation(br)

					# if @header.mapFileConfiguration.testResultInformationPerExtensionDie
					# 	# todo 

					# if @header.mapFileConfiguration.lineCategoryInformation
					# 	# todo


				when 3
					# header
					# test result
					# line category
					# extended test result
					# extended line category
					break
				when 4
					# 1024 category?
					break
			callback(@mapFile)


	# parseDieResult= (br)->
	# 	ret=[]
	# 	dieCount=@header.mapDataAreaRowSize*@header.mapDataAreaLineSize
	# 	for i in [0...dieCount]
	# 		ret.push new TestResultPerDie(br)
	# 	return ret

