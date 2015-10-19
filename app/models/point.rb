class Point < ActiveRecord::Base
  attr_accessible :issue_agen, :issue_time, :street_num, :violation_, :vehicle_co, :issue_date, :vehicle_ma, 
    :vehicle_st, :plate_type, :ticket_loc, :badge_numb, :street_nam, :route, :violation1, :license_st, :comment, :fine_amt, :lat, :long

  def self.get_geocode
    # point = Point.find(index)
    Point.all.each do |point|
      if !point.lat or !point.long
        unless point.ticket_loc.include? "*"
          # if count % 100 == 0
          #   sleep 1
          # end
          towns = {
            JP: "Jamaica Plain",
            AX: "Boston",
            CHAS: "Charlestown",
            DOR: "Dorchester",
            EB: "East Boston",
            HP: "Hyde Park",
            MATT: "Mattapan",
            ROS: "Roslindale",
            ROX: "Roxbury",
            SA: "Boston",
            SB: "South Boston",
            WROX: "West Roxbury"
          }
          town = towns[point.route] || "Boston, MA"
          address = "#{point.ticket_loc} #{town}"
          request = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyA6K_vSRWg2ULzhppVnxvYDxO6yqmHxL8g&address=#{address}")
          parsed = JSON.parse(request.body)
          # puts parsed
          point.geo_results = request.body
          if parsed['results'].length == 1
            point.lat = parsed['results'][0]['geometry']['location']['lat']
            point.long = parsed['results'][0]['geometry']['location']['lng']
          end
          point.save
          puts "[#{point.id}] #{point.ticket_loc}: #{point.lat}, #{point.long}"
        end
      end
    end
  end

  def self.resetLatLng
    file = File.read('app/assets/javascripts/tickets_long.json')
    json = JSON.parse(file)
    i = 1
    json.each do |pnt|
      dbPoint = Point.find(i)
      dbPoint.lat = pnt['Lat']
      dbPoint.long = pnt['Long']
      dbPoint.ticket_loc = pnt['Ticket_Loc']
      dbPoint.issue_date = pnt['Issue_Date']
      dbPoint.issue_time = pnt['Issue_Time']
      dbPoint.route = pnt['Route']
      dbPoint.badge_numb = pnt['Badge_Numb']
      dbPoint.issue_agen = pnt['Issue_Agen']
      dbPoint.violation_ = pnt['Violation_']
      dbPoint.violation1 = pnt['Violation1']
      dbPoint.fine_amt = pnt['Fine_Amt']
      dbPoint.plate_type = pnt['Plate_Type']
      dbPoint.license_st = pnt['License_St']
      dbPoint.vehicle_ma = pnt['Vehicle_Ma']
      dbPoint.vehicle_co = pnt['Vehicle_Co']
      dbPoint.vehicle_st = pnt['Vehicle_St']
      dbPoint.comment = pnt['Comment']
      dbPoint.street_num = pnt['Street_Num']
      dbPoint.street_nam = pnt['Street_Nam']
      dbPoint.save
      i += 1
    end
  end

end
