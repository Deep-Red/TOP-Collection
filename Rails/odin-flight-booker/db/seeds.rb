# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
airport = Airport.create([{code: 'SFO'}, {code: 'JFK'}, {code: 'RDU'}, {code: 'LYH'}])

y = 1
x = 4
airports = Airport.order(:created_at).take(x)
12.times do
  y += 1
  i = (y % x)
  j = ((i + rand(4)) % 4)
  airport_a = airports[i]
  airport_b = airports[j]
  flight = Flight.new
  flight.origin_id = airport_a.id
  flight.destination_id = airport_b.id
  flight.start = (Time.now + (i * 10000))
  flight.duration = "#{i + j * 3 + 1 / 2} Hours"
  flight.save
end
