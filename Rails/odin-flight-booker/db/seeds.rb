# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
airport = Airport.create([{code: 'SFO'}, {code: 'JFK'}, {code: 'RDU'}, {code: 'LYH'}])

y = 1
x = airport.length
airports = Airport.order(:created_at).take(x)
44.times do
  y += 1
  airports.each do |o|
    airports.each do |d|
      if o != d
        flight = Flight.new
        flight.origin_id = o.id
        flight.destination_id = d.id
        flight.start = (Time.now + (y * 86400))
        flight.duration = "#{rand(4) + 1} Hours"
        flight.save
      end
    end
  end
end

#  i = (y % x)
#  j = ((i + 1 + rand(3)) % 4)
#  airport_a = airports[i]
#  airport_b = airports[j]
#  flight = Flight.new
#  flight.origin_id = airport_a.id
#  flight.destination_id = airport_b.id
#  flight.start = (Time.now + (y * 86400))
#  flight.duration = "#{i + j * 3 % 5 + 1} Hours"
#  flight.save
#end
