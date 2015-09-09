wgs84 =			require 'wgs84-util'





module.exports = (program) ->
	console.log 'Calculating GPS stuff.'
	program.center =
		type:			'Point'
		coordinates:	[
			program.station.latitude
			program.station.longitude
		]

	program.east = wgs84.destinationPoint(program.center, 0, program.radius).coordinates[1]
	program.north = wgs84.destinationPoint(program.center, 90, program.radius).coordinates[0]
	program.west = wgs84.destinationPoint(program.center, 180, program.radius).coordinates[1]
	program.south = wgs84.destinationPoint(program.center, 270, program.radius).coordinates[0]

	program.dLongitude = Math.abs program.east - program.west
	program.dLatitude = Math.abs program.north - program.south

	return program
