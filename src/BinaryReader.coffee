
module.exports = class BinaryReader
	constructor: (@buffer) ->
		@position=0

	readAsBytes:(bytes,preventAutoForward)->
		if preventAutoForward? and preventAutoForward
			@position+=bytes

		return @buffer.slice(@position,@position)

	readAsString:(bytes,preventAutoForward)->
		return @readAsBytes(bytes).toString()

	readAsHex:(bytes,preventAutoForward)->
		return @readAsBytes(bytes).toString('hex')

	readAsInt:(bytes,preventAutoForward)->
		return parseInt(@readAsBytes(bytes).toString('hex'),'16')

	readAsBit:(bytes,preventAutoForward)->
		return @readAsInt(bytes).toString(2)




