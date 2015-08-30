class TimeRemaining extends Subscriber

	new: ( @animationQueue ) =>
		super 0, 0, 0, 0

		@line = {
			[[{\fnSource Sans Pro Semibold\bord2\fs30\pos(]]
			[[-100,0]]
			[[)\3c&H2D2D2D&\c&HFC799E&\an3}]]
			0
		}

		@lastTime = -1
		@position = -100
		@lastSize = -1
		@sizeCache = {}
		@animation = Animation -100, 4, 0.25, @\animatePos, nil, 0.25

	updateSize: ( w, h ) =>
		super w, h
		@line[2] = ([[%g,%g]])\format @position, @y + (hover_zone-4)*bar_height
		return true

	animatePos: ( animation, value ) =>
		@position = @w - value
		@line[2] = ([[%g,%g]])\format @position, @y + (hover_zone-4)*bar_height
		@needsUpdate = true

	update: ( mouseX, mouseY, mouseOver ) =>
		update = super mouseX, mouseY, mouseOver

		if @hovered or @animation.isRegistered
			timeRemaining = math.floor mp.get_property_number 'playtime-remaining', 0
			if timeRemaining != @lastTime
				update = true
				@line[4] = ([[–%d:%02d:%02d]])\format timeRemaining/3600, (timeRemaining/60)%60, timeRemaining%60
				size = #@line[4]
				if size != @lastSize
					unless @sizeCache[size]
						@sizeCache[size] = Bounds\instance!\sizeOf {table.concat @line}
						@sizeCache[size].w += 4

					@sizeCache.current = @sizeCache[size]
					@lastSize = size
				@lastTime = timeRemaining

		return update
