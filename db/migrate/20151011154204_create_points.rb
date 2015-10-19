class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.text :content
      t.string :ticket_loc # "1759 DORCHESTER AVE",
      t.string :issue_date # "02/25/2015 12:00:00 AM",
      t.string :issue_time # "4:10:00 PM",
      t.string :route # "DOR",
      t.integer :badge_numb # "201",
      t.integer :issue_agen # "1",
      t.integer :violation_ # "14",
      t.string :violation1 # "NO STOP OR STAND",
      t.integer :fine_amt # "75",
      t.string :plate_type # "PA",
      t.string :license_st # "MA",
      t.string :vehicle_ma # "HOND",
      t.integer :vehicle_co # "8",
      t.string :vehicle_st # "4D",
      t.string :comment # "OFFICER ERROR",
      t.string :street_num # "1759",
      t.string :street_nam # "DORCHESTER AVE",
      t.float :lat # "42.2902",
      t.float :long # "-71.0633"

      t.timestamps null: false
    end
  end
end
