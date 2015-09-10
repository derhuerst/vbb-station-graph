hifo =			require 'hifo'





module.exports = (program) ->
	console.log 'Calculating GPS stuff.'

	east = hifo hifo.highest('longitude'), 1
	north = hifo hifo.highest('latitude'), 1
	west = hifo hifo.lowest('longitude'), 1
	south = hifo hifo.lowest('latitude'), 1

	for lineId, stations of program.adjacent
		line = program.lines[lineId]
		for stationId, station of stations
			east.add station
			north.add station
			west.add station
			south.add station

	program.box =
		east:	east.data[0].longitude + .001
		north:	north.data[0].latitude + .001
		west:	west.data[0].longitude - .001
		south:	south.data[0].latitude - .001

		width:	east.data[0].longitude - west.data[0].longitude + .01
		height:	north.data[0].latitude - south.data[0].latitude + .01

	return program
