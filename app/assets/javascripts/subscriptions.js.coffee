# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Gui
	
	constructor: ->
		@currentModal
		@geocoder = new google.maps.Geocoder()
		@modalWindowSpace = $('#modal-window-space')
		@mapStyles = [{stylers:[{invert_lightness:true}]},{featureType:"road.arterial",stylers:[{hue:"#f89406"},{lightness:30},{invert_lightness:false},{saturation:53}]},{featureType:"road.highway",stylers:[{hue:"#f89406"},{invert_lightness:false},{lightness:17},{saturation:53}]},{featureType:"water",stylers:[{hue:"#00fff7"},{lightness:41},{saturation:-52},{gamma:1.62}]},{featureType:"landscape",stylers:[{hue:"#3300ff"},{lightness:2}]},{featureType:"transit",stylers:[{lightness:75}]},{featureType:"poi",stylers:[{visibility:"off"}]}]
		@initSelectPlaceMap(50, 20)

	initSelectPlaceMap: (lat, lng) ->
		centerPoint = new google.maps.LatLng( lat, lng )	
		mapOptions = { zoom: 12, center: centerPoint, mapTypeId: google.maps.MapTypeId.ROADMAP}
		map = new google.maps.StyledMapType(@map_styles, {name: "Mapa"})
		map = new google.maps.Map(document.getElementById('select-place-location-map'), mapOptions);
		locationMapStyled = new google.maps.StyledMapType(@mapStyles, {name: "Map"});
		map.mapTypes.set('location_map', locationMapStyled)
		map.setMapTypeId('location_map')
		marker = new google.maps.Marker({ position: centerPoint, map: map })

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