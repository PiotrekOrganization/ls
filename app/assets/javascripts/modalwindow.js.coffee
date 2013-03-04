$.extend $.fn,
	modalWindow: ->
		@each ->
			e = $(this)

			# init DOM elements
			final_container = e.parent()
			content = e
			box = $('<div class="modal-window-box" style="display:none"></div>')
			mask = $('<div class="modal-window-mask" style="display:none"></div>')
			close = $('<a href="#" class="modal-window-close">Close</a>')

			# place everything in right container
			content.prependTo( box )
			close.prependTo( box )
			final_container.append( mask )
			final_container.append( box )

			# fit to screen
			window_height = $(window).height()
			box_height = box.height()
			box.css('top', parseInt( (window_height - box_height) / 3 ) )
			window_width = $(window).width()
			box_width = $(box).width()
			box.css('left', parseInt( (window_width - box_width) / 2 ) )

			# so let's show our stuff
			box.fadeIn()
			mask.fadeIn()

			# close button
			close.click( (event) -> 
				event.preventDefault()
				box.fadeOut( 300, ->
					$(this).remove()
				)
				mask.fadeOut( 300, ->
					$(this).remove()
				)
			)

			# close on mask click too
			mask.click( (event) -> 
				event.preventDefault()
				box.fadeOut( 300, ->
					$(this).remove()
				)
				mask.fadeOut( 300, ->
					$(this).remove()
				)
			)