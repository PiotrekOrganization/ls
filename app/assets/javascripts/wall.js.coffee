# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Gui
	
	constructor: ->
		@currentModal
		@geocoder = new google.maps.Geocoder()
		@newPostTriggers()
		@wallTriggers()
		@modalWindowSpace = $('#modal-window-space')
		@mapStyles = [{stylers:[{invert_lightness:true}]},{featureType:"road.arterial",stylers:[{hue:"#f89406"},{lightness:30},{invert_lightness:false},{saturation:53}]},{featureType:"road.highway",stylers:[{hue:"#f89406"},{invert_lightness:false},{lightness:17},{saturation:53}]},{featureType:"water",stylers:[{hue:"#00fff7"},{lightness:41},{saturation:-52},{gamma:1.62}]},{featureType:"landscape",stylers:[{hue:"#3300ff"},{lightness:2}]},{featureType:"transit",stylers:[{lightness:75}]},{featureType:"poi",stylers:[{visibility:"off"}]}]

	wallTriggers: ->
		$('a.note-modal-show-location').click (event) =>
			event.preventDefault
			lng = $(event.currentTarget).attr('data-lng')
			lat = $(event.currentTarget).attr('data-lat')
			@openModalWithStaticMap( lat, lng )
		$('a.note-add-comment').each ->
			note_id = $(this).attr('data-id')
			$(this).click (event) ->
			 	comment_box = $('#note-'+note_id+'-comment-box')
			 	comment_box.fadeToggle 600, ->
			 		$(window).one 'click', ->
			 			comment_box.fadeOut()
			 		comment_box.click (event) ->
			 			event.stopPropagation()

	newPostTriggers: ->
		$('a.note-change-location').click (event) =>
			event.preventDefault
			button = event.currentTarget
			@currentPosition = new google.maps.LatLng( parseFloat($(button).attr('data-lat')), parseFloat($(button).attr('data-lng')) )
			@openModalWithSelectMap( HandlebarsTemplates['change_location'] )
			
	openModalWithSelectMap: (content) ->
		box = $('<div></div>')
		box.append(content)
		@modalWindowSpace.append(box)
		box.modalWindow()
		@currentModal = box
		@mapInitialize()

	openModalWithStaticMap: (lat, lng) ->
		box = $('<div></div>')
		box.append('<div id="map_canvas" style="height: 400px;"></div>')
		@modalWindowSpace.append(box)
		box.modalWindow()
		@currentModal = box
		centerPoint = new google.maps.LatLng( lat, lng )	
		mapOptions = { zoom: 12, center: centerPoint, mapTypeId: google.maps.MapTypeId.ROADMAP}
		map = new google.maps.StyledMapType(@map_styles, {name: "Mapa"})
		map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
		locationMapStyled = new google.maps.StyledMapType(@mapStyles, {name: "Map"});
		map.mapTypes.set('location_map', locationMapStyled)
		map.setMapTypeId('location_map')

	mapInitialize: ->
		mapOptions = { zoom: 12, center: @currentPosition, mapTypeId: google.maps.MapTypeId.ROADMAP}
		map = new google.maps.StyledMapType(@map_styles, {name: "Mapa"})
		map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
		locationMapStyled = new google.maps.StyledMapType(@mapStyles, {name: "Map"});
		map.mapTypes.set('location_map', locationMapStyled)
		map.setMapTypeId('location_map')
		google.maps.event.addListener(map, "click", (e) => @locationSelected(e) ) 

	locationSelected: (e) ->
		lat = e.latLng.lat()
		lng = e.latLng.lng()
		$('#new-post-form #note_latitude').val(lat)
		$('#new-post-form #note_longitude').val(lng)
		@getAddress(e.latLng)
		@currentModal.parent().find('.modal-window-close').click()

	getAddress: (latLng) ->
		@geocoder.geocode( {'latLng': latLng}, (results, status) ->
			newPostLocationNameField = $('#new-post-form .user-current-location')
			if status == google.maps.GeocoderStatus.OK
				if(results[0])
					newPostLocationNameField.html(results[0].formatted_address)
					console.log(results[0].formatted_address)
				else
					newPostLocationNameField.html('')
			else
				newPostLocationNameField.html('')
		)

$ -> new Gui