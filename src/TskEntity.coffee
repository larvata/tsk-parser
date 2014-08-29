exports.MapFileConfiguration = class MapFileConfiguration
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


exports.MapFileHeader = class MapFileHeader
	constructor:(br)->

			# Map File Header Start

			# Wafer Testing Setup Data
			@operatorName
			@deviceName
			@waferSize
			@machineNo
			@indexSizeX
			@indexSizeY
			@standardOrientationFlatDirection
			@finalEditingMachineType

			# Map Version
			# 0:Normal
			# 1: 250,000 Chilps
			# 2: 256 Multi-sites
			# 3: 256 Multi-sites (without extended header information)
			# 4: 1024 category
			@mapVersion

			@mapDataAreaRowSize
			@mapDataAreaLineSize

			# Map Data Form Group Management
			@mapDataForm

			# Wafer Specific Data
			@waferId
			@numberOfProbing
			@lotNo
			@cassetteNo
			@slotNo

			# Wafer Probing Coordinate System Data
			@xCoordinatesIncreaseDirection
			@yCoordinatesIncreaseDirection
			@referenceDieSettingProcedures
			@reserved
			@targetDiePositionX
			@targetDiePositionY
			@referenceDieCoordinatorX
			@referenceDieCoordinatorY
			@probingStartPosition
			@probingDirection
			@reserved
			@distanceXtoWaferCenterDieOrigin
			@distanceYtoWaferCenterDieOrigin
			@coordinatorXofWaferCenterDie
			@coordinatorYofWaferCenterDie

			# Inforamtion Per Die
			@firstDieCoordinatorX
			@firstDieCoordinatorY

			# Wafer Test Start Time Data
			@startYear
			@startMonth
			@startDay
			@startHour
			@startMinute
			@reserved

			# Wafer Test End Time Data
			@endYear
			@endMonth
			@endDay
			@endHour
			@endMinute
			@reserved

			# Wafer Loading Time Data
			@loadYear
			@loadMonth
			@loadDay
			@loadHour
			@loadMinute
			@reserved

			# Wafer Unloading Time Data
			@unloadYear
			@unloadMonth
			@unloadDay
			@unloadHour
			@unloadMinute
			@reserved

			# Vega
			@vegaMachineNo
			@vegaMachineNo2

			@sepcialCharacters

			# Testing Result
			@testingEndInformation
			@reserved
			@totalTestedDice
			@totalPassDice
			@totalFailDice

			# Test Die Inforamtion Address
			@testDieInformationAddress


			@numberOfLineCategoryData
			@linCategoryAddress

			# Extended Map Inforamtion
			@mapFileConfiguration
			@maxMultiSite
			@maxCategories
			@reserved

			# Map File Header End

			

exports.TestResultPerDie = class TestResultPerDie
	constructor: (br) ->
		@dieTestResult
		@marking
		@failMarkInspection
		@reProbingResult
		@needleMarkInspectionResult
		@dieCoordinatorValueX

		@dieProperty
		@needleMarkInspectionExecutionDieSelection
		@samplingDie
		@codeBitOfCorrdinatorValueX
		@codeBitOfCorrdinatorValueY
		@dummyData
		@dieCoordinatorVauleY

		@measurementFinish
		@rejectChipFlag
		@testExecutionSite
		@blockAreaJudegmentFuntion
		@categoryData



exports.ExtensionHeaderInformation = class ExtensionHeaderInformation
	constructor: (br)->
		br.skip(52)
		@testedDice=br.readAsInt(4)
		@testedPassDice=br.readAsInt(4)
		@testedFailDice=br.readAsInt(4)

exports.TskMapFile = class TskMapFile
	constructor: () ->
		@header
		@dieResults
