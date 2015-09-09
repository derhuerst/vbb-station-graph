svg =			require 'svg-builder'





module.exports = (program) ->
	console.log 'Generating the SVG.'
	program.svg = svg.newInstance()
	program.svg.width(1000).height 1000

	for lineId, stations of program.graph
		line = program.lines[lineId]
		for stationId, station of stations
			program.svg.line
				x1:		500
				y1:		500
				x2: 	(station.longitude - program.west) / program.dLongitude * 1000
				y2: 	(station.latitude - program.south) / program.dLatitude * 1000
				stroke:	'black'
			program.svg.line

	program.svg = program.svg.render()
	return program
