# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


  json = File.read('app/assets/javascripts/tickets.json')
  points = JSON.parse(json)
  points.each do |point|
    newPoint = Point.new
    newPoint.ticket_loc = point["Ticket_Loc"]
    newPoint.issue_date = point["Issue_Date"]
    newPoint.issue_time = point["Issue_Time"]
    newPoint.route = point["Route"]
    newPoint.badge_numb = point["Badge_Numb"]
    newPoint.issue_agen = point["Issue_Agen"]
    newPoint.violation_ = point["Violation_"]
    newPoint.violation1 = point["Violation1"]
    newPoint.fine_amt = point["Fine_Amt"]
    newPoint.plate_type = point["Plate_Type"]
    newPoint.license_st = point["License_St"]
    newPoint.vehicle_ma = point["Vehicle_Ma"]
    newPoint.vehicle_co = point["Vehicle_Co"]
    newPoint.vehicle_st = point["Vehicle_St"]
    newPoint.comment = point["Comment"]
    newPoint.street_num = point["Street_Num"]
    newPoint.street_nam = point["Street_Nam"]
    newPoint.lat = point["Lat"]
    newPoint.long = point["Long"]
    newPoint.content = point
    newPoint.save
  end



