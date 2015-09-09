Q =				require 'q'
fs =			require 'fs'





module.exports = (program) ->
	file = program.station.id + '.svg'
	console.log "Saving to #{file}."
	deferred = Q.defer()
	stream = fs.createWriteStream file
	stream.write program.svg

	stream.on 'finish', () -> deferred.resolve program

	return deferred.promise
