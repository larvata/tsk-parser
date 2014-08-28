BinaryReader = require './BinaryReader'
fs = require 'fs'

class MapFileConfiguration
	@bitSet=[]
	constructor: (@value) ->
		@bitSet=@value.toString(2).split('').reverse()
	getRawData:()->
		ret=@bitSet
		ret.reverse()
		return parseInt(ret.join(''),2)
	headerInformation:(bitValue)->
		if bitValue?
			@bitSet[0]=value
		return @bitSet[0]||0
	testResultInformationPerDie:(bitValue)->
		if bitValue?
			@bitSet[1]=value
		return @bitSet[1]||0
	lineCategoryInformation:(bitValue)->
		if bitValue?
			@bitSet[2]=value
		return @bitSet[2]||0
	extensionHeaderInformation:(bitValue)->
		if bitValue?
			@bitSet[3]=value
		return @bitSet[3]||0
	testResultInformationPerExtensionDie:(bitValue)->
		if bitValue?
			@bitSet[4]=value
		return @bitSet[4]||0
	extensionLineCategoryInformation:(bitValue)->
		if bitValue?
			@bitSet[5]=value
		return @bitSet[5]||0



module.exports = class TskParser
	constructor: (filePath) ->
		fs.readFile "test/001.QR2352-D5U278-CP-1",(err,data)->

			br=new BinaryReader(data)

			# Map File Header Start

			# Wafer Testing Setup Data
			operatorName =br.readAsString(20)
			deviceName = br.readAsString(16)
			waferSize = br.readAsInt(2)
			machineNo = br.readAsInt(2)
			indexSizeX = br.readAsInt(4)
			indexSizeY = br.readAsInt(4)
			standardOrientationFlatDirection = br.readAsInt(2)
			finalEditingMachineType  = br.readAsInt(1)

			# Map Version
			# 0:Normal
			# 1: 250,000 Chilps
			# 2: 256 Multi-sites
			# 3: 256 Multi-sites (without extended header information)
			# 4: 1024 category
			mapVersion=br.readAsInt(1)

			mapDataAreaRowSize=br.readAsInt(2)
			mapDataAreaLineSize=br.readAsInt(2)

			# Map Data Form Group Management
			mapDataForm=br.readAsInt(4)

			# Wafer Specific Data
			waferId=br.readAsString(21)
			numberOfProbing=br.readAsInt(1)
			lotNo=br.readAsString(18)
			cassetteNo=br.readAsInt(2)
			slotNo=br.readAsInt(2)

			# Wafer Probing Coordinate System Data
			xCoordinatesIncreaseDirection=br.readAsInt(1)
			yCoordinatesIncreaseDirection=br.readAsInt(1)
			referenceDieSettingProcedures=br.readAsInt(1)
			reserved=br.readAsInt(1)
			targetDiePositionX=br.readAsInt(4)
			targetDiePositionY=br.readAsInt(4)
			referenceDieCoordinatorX=br.readAsInt(2)
			referenceDieCoordinatorY=br.readAsInt(2)
			probingStartPosition=br.readAsInt(1)
			probingDirection=br.readAsInt(1)
			reserved=br.readAsInt(2)
			distanceXtoWaferCenterDieOrigin=br.readAsInt(4)
			distanceYtoWaferCenterDieOrigin=br.readAsInt(4)
			coordinatorXofWaferCenterDie=br.readAsInt(4)
			coordinatorYofWaferCenterDie=br.readAsInt(4)

			# Inforamtion Per Die
			firstDieCoordinatorX=br.readAsInt(4)
			firstDieCoordinatorY=br.readAsInt(4)

			# Wafer Test Start Time Data
			startYear=br.readAsString(2)
			startMonth=br.readAsString(2)
			startDay=br.readAsString(2)
			startHour=br.readAsString(2)
			startMinute=br.readAsString(2)
			reserved=br.readAsBytes(2)

			# Wafer Test End Time Data
			endYear=br.readAsString(2)
			endMonth=br.readAsString(2)
			endDay=br.readAsString(2)
			endHour=br.readAsString(2)
			endMinute=br.readAsString(2)
			reserved=br.readAsBytes(2)

			# Wafer Loading Time Data
			loadYear=br.readAsString(2)
			loadMonth=br.readAsString(2)
			loadDay=br.readAsString(2)
			loadHour=br.readAsString(2)
			loadMinute=br.readAsString(2)
			reserved=br.readAsBytes(2)

			# Wafer Unloading Time Data
			unloadYear=br.readAsString(2)
			unloadMonth=br.readAsString(2)
			unloadDay=br.readAsString(2)
			unloadHour=br.readAsString(2)
			unloadMinute=br.readAsString(2)
			reserved=br.readAsBytes(2)

			# Vega
			vegaMachineNo=br.readAsString(4)
			vegaMachineNo2=br.readAsString(4)

			sepcialCharacters=br.readAsString(4)

			# Testing Result
			testingEndInformation=br.readAsInt(1)
			reserved=br.readAsBytes(1)
			totalTestedDice=br.readAsInt(2)
			totalPassDice=br.readAsInt(2)
			totalFailDice=br.readAsInt(2)

			# Test Die Inforamtion Address
			testDieInformationAddress=br.readAsInt(4)

			numberOfLineCategoryData=br.readAsInt(4)
			linCategoryAddress=br.readAsInt(4)

			# Extended Map Inforamtion
			mapFileConfiguration=new MapFileConfiguration(br.readAsBit(2))
			maxMultiSite=br.readAsInt(2)
			maxCategories=br.readAsInt(2)
			reserved=br.readAsBytes(2)

			# Map File Header End


			m.headerInformation()
			# Die Result Area
			# if @mapVersion
				# ...
			# _dieCount=mapDataAreaRowSize*mapDataAreaLineSize
			# _dieResultPost
			# for i in [0..._dieCount]










			# console.log totalPassDice
			console.log "---------"
			console.log mapVersion


			# waferSize = br.readBytes()
