Q =				require 'q'
vbbStatic =		require 'vbb-static'





load = (set) ->
	deferred = Q.defer()
	result = {}
	stream = vbbStatic[set] 'all'
	stream.on 'end', () -> deferred.resolve result
	stream.on 'data', (data) -> result[data.id] = data
	return deferred.promise



module.exports = (program) ->
	console.log 'Loading all stations and lines.'
	return Q.spread [
		load 'stations'
		load 'lines'
	], (stations, lines) ->
		console.log 'Looking for adjacent stations.'
		deferred = Q.defer()
		program.stations = stations
		program.lines = lines
		program.adjacent = {}

		trips = vbbStatic.trips 'all'
		trips.on 'end', () -> deferred.resolve program
		trips.on 'data', (trip) ->

			line = lines[trip.lineId]
			for currentStation, i in trip.stations
				continue unless currentStation.s is program.station.id
				nextStation = trip.stations[i + 1]
				continue unless nextStation
				program.adjacent[line.id] ?= {}
				nextStation = stations[nextStation.s]
				program.adjacent[line.id][nextStation.id] = nextStation

		return deferred.promise
