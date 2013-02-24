# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Gui
	
	constructor: ->
		@currentModal
		@geocoder = new google.maps.Geocoder()
		@newPostTriggers()
		@modalWindowSpace = $('#modal-window-space')
		@mapStyles = [{stylers:[{invert_lightness:true}]},{featureType:"road.arterial",stylers:[{hue:"#f89406"},{lightness:30},{invert_lightness:false},{saturation:53}]},{featureType:"road.highway",stylers:[{hue:"#f89406"},{invert_lightness:false},{lightness:17},{saturation:53}]},{featureType:"water",stylers:[{hue:"#00fff7"},{lightness:41},{saturation:-52},{gamma:1.62}]},{featureType:"landscape",stylers:[{hue:"#3300ff"},{lightness:2}]},{featureType:"transit",stylers:[{lightness:75}]},{featureType:"poi",stylers:[{visibility:"off"}]}]

	newPostTriggers: ->
		$('a.note-change-location').click (event) =>
			button = event.currentTarget
			@currentPosition = new google.maps.LatLng( parseFloat($(button).attr('data-lat')), parseFloat($(button).attr('data-lng')) )
			@openModalWindow( HandlebarsTemplates['change_location'] )
			
	openModalWindow: (content) ->
		box = $('<div></div>')
		box.append(content)
		@modalWindowSpace.append(box)
		box.modalWindow()
		@currentModal = box
		@mapInitialize()

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