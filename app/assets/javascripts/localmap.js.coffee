class LocalMap

	constructor: ->
		@coordinates = $('#current-coordinates')
		@lat = parseFloat(@coordinates.attr('data-lat'))
		@lng = parseFloat(@coordinates.attr('data-lng'))
		@localmap = $('#local-map')
		@mapStyles = [{stylers:[{invert_lightness:true}]},{featureType:"road.arterial",stylers:[{hue:"#f89406"},{lightness:30},{invert_lightness:false},{saturation:53}]},{featureType:"road.highway",stylers:[{hue:"#f89406"},{invert_lightness:false},{lightness:17},{saturation:53}]},{featureType:"water",stylers:[{hue:"#00fff7"},{lightness:41},{saturation:-52},{gamma:1.62}]},{featureType:"landscape",stylers:[{hue:"#3300ff"},{lightness:2}]},{featureType:"transit",stylers:[{lightness:75}]},{featureType:"poi",stylers:[{visibility:"off"}]}]
		height = $(window).height()
		width = $(window).width()
		@localmap.css('height', height - 40)
		@localmap.css('width', width)
		@initMap(@lat, @lng)
		@initHideButton()
		@navBar = $('#categories-menu')
		@navBar.hide()
		@map

	initMap: (lat, lng) ->
		centerPoint = new google.maps.LatLng( lat, lng )	
		mapOptions = { zoom: 10, center: centerPoint, mapTypeId: google.maps.MapTypeId.ROADMAP}
		@map = new google.maps.StyledMapType(@map_styles, {name: "Mapa"})
		@map = new google.maps.Map(document.getElementById('local-map'), mapOptions);
		locationMapStyled = new google.maps.StyledMapType(@mapStyles, {name: "Map"});
		@map.mapTypes.set('location_map', locationMapStyled)
		@map.setMapTypeId('location_map')
		marker = new google.maps.Marker({ position: centerPoint, map: @map, icon: '/assets/images/home-2.png' })
		@initLocalNotes()

	hideMap: ->
		@localmap.animate({ height: 0 }, 600, =>
			console.log('test')
			@navBar.fadeIn()
		)

	initHideButton: ->
		$('a.brand').click (event) =>
			event.preventDefault()
			@hideMap()

	initLocalNotes: ->
		$.get('/api/get_local_notes').done (data) =>
			for note in data
				@initNote(note)
				

	initNote: (note) ->
		position = new google.maps.LatLng( note.latitude, note.longitude )	
		marker = new google.maps.Marker({ position: position, map: @map, icon: '/assets/images/comment-map-icon.png' })
		infowindow = new google.maps.InfoWindow({content: note.content})
		google.maps.event.addListener(marker, 'click', =>
			infowindow.open(@map,marker)
		)


$ -> new LocalMap