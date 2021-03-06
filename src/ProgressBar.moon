class ProgressBar extends BarBase

	seekString = 'absolute-percent+%s'\format settings['seek-precision']

	new: =>
		super!
		@line[7] = @line[7]\format settings['bar-foreground-style']
		@lastPosition = 0

	clickHandler: =>
		mp.commandv "seek", Mouse.clickX*100/Window.w, seekString

	redraw: =>
		super!
		position = mp.get_property_number 'percent-pos', 0
		if position != @lastPosition
			@line[6] = position
			@lastPosition = position
			@needsUpdate = true

		return @needsUpdate
