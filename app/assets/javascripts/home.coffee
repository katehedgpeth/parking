# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class parking.MapView
  constructor: ->

  render: (data) =>
    @center = new google.maps.LatLng 42.354875, -71.090427
    # @setPoints(data)
    @styles = [
      {"elementType": "labels.icon",
      "stylers": [
        "visibility": "off"
      ]},
      {"stylers": [
        "saturation": -100 
        "lightness": -13 
        "gamma": 1.13
      ]}
    ]
    mapOpts = 
      center: @center
      zoom: 14
      styles: @styles      
    heatmapOpts = 
      radius: 15
      # data: []      
    @map = new google.maps.Map(document.getElementById('map'), mapOpts)
    @heatmap = new google.maps.visualization.HeatmapLayer(heatmapOpts)

    @getData()
    # @fusionTableHeatmap()

  getData: =>
    console.log "data loaded"
    $.ajax
      dataType: 'json'
      url: '/points'
      success: @browserHeatmap
      error: @loadError

  browserHeatmap: (data) =>
    pointArray = []
    data.forEach (datum) ->
      latLng = new google.maps.LatLng datum.lat, datum.long
      pointArray.push latLng
    @heatmap.setData(pointArray)

  fusionTableHeatmap: =>
    @fusionTable = new google.maps.FusionTablesLayer {
      query:
        select: 'Ticket_Loc'
        from: '1iN5Uxwjmjae7vWAfVVTSWAR4mp5LxuoTOFiDWcXN'
      heatmap:
        enabled: true
    }
    @fusionTable.setMap(@map)


  setPoints: (points) ->
    i = 0
    stepper = 300
    max = points.length
    createText = (text, addon) ->
      p = document.createElement('div')
      text += addon if addon?
      p.textContent = text
      document.body.appendChild(p)
    createText('[')
    recursiveGetter = (start) ->
      if start < max
      # if start < points.length
        pointArray = points.slice(start, stepper)
        for point in pointArray
          if !point.Lat?
            geocoder = new google.maps.Geocoder()
            geocoder.geocode {address: "#{point.Ticket_Loc}, Boston MA", region: 'US'}, (geoObj, status) ->
              if status is "OK"
                point.Lat = geoObj[0].geometry.location.lat()
                point.Long = geoObj[0].geometry.location.lng()
                $.ajax
                  url         : "points/#{point.id}?point=#{JSON.stringify(point)}"
                  # data        : 
                  type        : 'PUT'
                  success     : (point) -> createText(JSON.stringify(point), ',')
                # point.success = status
              # else
                # point.error = status
          # else 
          #   createText(JSON.stringify(point), ',')
          
            # point.Lat = "new Lat" if !point.Lat? or point.Lat is ""
            # point.Long = "new Long" if !point.Long? or point.Long is ""
            


          i++
        start += stepper
        setTimeout( () ->
           recursiveGetter(start)
        , 1000)
      else
        createText ']'

    setTimeout( () ->
      recursiveGetter(0)
    , 1000)

    console.log i
        # geocoder.geocode {address: "#{point.Ticket_Loc}, Boston MA", region: 'US'}, (geoObj, status) ->
        #   if geoObj?
        #     point.Lat = geoObj[0].geometry.location.J
        #     point.Long = geoObj[0].geometry.location.M
        #   else
        #     point.error = "couldn't get address"


    # for point in @data
    #   geocoder.geocode {address: "#{point.Ticket_Loc}, Boston MA", region: 'US'}, (geoObj, status) ->
    #     if geoObj?
    #       point.Lat = geoObj[0].geometry.location.J
    #       point.Long = geoObj[0].geometry.location.M
    #     else
    #       point.error = "couldn't get address"
    # pointsArray = []
    # subset = points.slice(0, max)
    # geocoder = 
    #   geocode: (input, callback) ->
    #     callback()
    # i = 0
      # if i < max
        # lat = point.lat if point.lat
        # long = point.long if point.long
        # if lat? && long?
        #   pointsArray.push(new google.maps.LatLng lat, long) 
        # else
              # pointsArray.push new google.maps.LatLng(lat, lng)
        # i++
      # else
      #   break

    # $("#map").text(JSON.stringify(@data))
    # pointsArray

  loadError: (data) ->
    console.log data

  pointLats: (geoObj) ->
