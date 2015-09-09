Q =				require 'q'
vbbStatic =		require 'vbb-static'





module.exports = (program) ->
	console.log 'Looking for the station.'
	return vbbStatic.stations true, program.station
	.then (results) ->
		program.station = results[0]
		return program
