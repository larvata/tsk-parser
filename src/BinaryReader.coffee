
module.exports = class BinaryReader
	constructor: (@buffer) ->
		@position=0

	readAsBytes:(bytes,preventAutoForward)->
		ret=@buffer.slice(@position,@position+bytes);
		if preventAutoForward? and preventAutoForward
		else
			@position+=bytes

		return ret

	readAsString:(bytes,preventAutoForward)->
		return @readAsBytes(bytes).toString()

	readAsHex:(bytes,preventAutoForward)->
		return @readAsBytes(bytes).toString('hex')

	readAsInt:(bytes,preventAutoForward)->
		return parseInt(@readAsBytes(bytes).toString('hex'),'16')

	readAsBit:(bytes,preventAutoForward)->
		return @readAsInt(bytes).toString(2)

	skip:(bytesToSkip)->
		@position+=bytesToSkip

	goto:(position)->
		@position=position




