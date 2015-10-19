  def getGeocode(index)
    max = 5
    point = Point.find(index)
    nextIndex = index + 1
    if !point.lat? or !point.long?
        sleep 1
        address = "#{point.ticket_loc} Boston MA"
        request = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyA6K_vSRWg2ULzhppVnxvYDxO6yqmHxL8g&address=#{address}")
        request = JSON.parse(request.body)
        point.lat = request['geometry']['location']['lat']
        point.long = request['geometry']['location']['lng']
        point.save
        puts "#{point.id}: #{point.lat}, #{point.long}"
        if nextIndex < max
            getGeocode(nextIndex)
        end
    else
        getGeocode(nextIndex)
    end
  end

  getGeocode(1)
