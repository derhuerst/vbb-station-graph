Q =				require 'q'
inquirer =		require 'inquirer'
Autocomplete =	require 'vbb-stations-autocomplete'





module.exports = (program) ->
	deferred = Q.defer()

	if program.station
		deferred.resolve program
		return deferred.promise

	autocomplete = Autocomplete 5
	# todo: search when autocompletion failed
	inquirer.prompt [{
		type:		'autocomplete',
		name:		'station',
		message:	'Where are you?',
		choices:	() -> (input) ->
			if not input
				choices = Q.defer()
				choices.resolve []
				return choices.promise
			return autocomplete.suggest input
			.then (results) ->
				choices = []
				for result in results
					choices.push
						name:	result.name
						value:	result.id
				return choices
	}], (answers) ->
		program.station = answers.station
		deferred.resolve program

	return deferred.promise
