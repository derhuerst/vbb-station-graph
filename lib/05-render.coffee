svg =			require 'svg-builder'
util =			require 'vbb-util'





module.exports = (program) ->
	console.log 'Generating the SVG.'

	scale = 1 / program.box.width * 1000
	program.svg = svg.newInstance()
	.width program.box.width * scale
	.height program.box.height * scale

	x1 = Math.abs program.station.longitude - program.box.west
	x1 = x1 * scale
	y1 = Math.abs program.box.north - program.station.latitude
	y1 = y1 * scale

	for lineId, stations of program.adjacent
		line = program.lines[lineId]
		for stationId, station of stations
			x2 = Math.abs station.longitude - program.box.west
			x2 = x2 * scale
			y2 = Math.abs program.box.north - station.latitude
			y2 = y2 * scale

			if util.lines.colors[line.type] and util.lines.colors[line.type][line.name]
				color = util.lines.colors[line.type][line.name].bg
			else if util.products[line.type]
				color = util.products[line.type].color
			else color = util.lines.colors.unknown

			program.svg.line
				class:		"line #{line.name}"
				x1:			x1
				y1:			y1
				x2:			x2
				y2:			y2
				stroke:		color
				'stroke-width':	3

			program.svg.circle
				class:		"station #{station.id}"
				r:			5
				cx:			x2
				cy:			y2
				fill:		color

			program.svg.text {
				x:			x2 + 10
				y:			y2
				fill:		color
				'font-size':	15
				'font-family':	'Helvetica'
			}, station.name

	program.svg.circle
		id:			"station #{program.station.id}"
		r:			5
		cx:			x1
		cy:			y1
		fill:		'black'

	program.svg = program.svg.render()
	return program
