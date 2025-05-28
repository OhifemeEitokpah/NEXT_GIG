# db/seeds.rb
require 'faker'

# Clear existing data
Booking.delete_all
Event.delete_all
Venue.delete_all
User.delete_all

# Create one musician
musician = User.create!(
  name:     'John Performer',
  email:    'musician@example.com',
  password: 'password',
  password_confirmation: 'password',
  role:     :musician,
  bio:      Faker::Quote.famous_last_words,
  genre:    Faker::Music.genre
)

# Create one organiser
organiser = User.create!(
  name:     'Venue Owner',
  email:    'owner@example.com',
  password: 'password',
  password_confirmation: 'password',
  role:     :organiser,
  bio:      Faker::Lorem.sentence(word_count: 10)
)

# List of real venues in Berlin
venues_data = [
  { name: 'Prater Garten',         address: 'Kastanienallee 7-9',   city: 'Berlin', country: 'Germany', description: 'Historic beer garden with open air performances.' },
  { name: 'Quasimodo',             address: 'Hardenbergstraße 12A', city: 'Berlin', country: 'Germany', description: 'Renowned jazz club with live music.' },
  { name: 'Donau115',              address: 'Donaustraße 115',      city: 'Berlin', country: 'Germany', description: 'Cozy bar hosting acoustic nights.' },
  { name: 'St. Oberholz',          address: 'Rosenthaler Str. 72A', city: 'Berlin', country: 'Germany', description: 'Cafe and bar popular with creatives.' },
  { name: 'Clärchens Ballhaus',    address: 'Auguststraße 24',      city: 'Berlin', country: 'Germany', description: 'Historic ballroom with live music events.' },
  { name: 'BKA Theater',           address: 'Am Flutgraben 2',      city: 'Berlin', country: 'Germany', description: 'Theatre and bar for eclectic performances.' },
  { name: 'White Trash Fast Food', address: 'Am Falkplatz 5',      city: 'Berlin', country: 'Germany', description: 'Alternative venue with live shows.' },
  { name: 'Kookabarra Berlin',     address: 'Spandauer Str. 1',     city: 'Berlin', country: 'Germany', description: 'Australian bar with open stage nights.' },
  { name: 'Radialsystem V',        address: 'Holzmarktstraße 33',   city: 'Berlin', country: 'Germany', description: 'Cultural venue with diverse programming.' },
  { name: 'The Hat Bar',           address: 'Torstraße 79',         city: 'Berlin', country: 'Germany', description: 'Speakeasy-style bar with local acts.' }
]

venues = venues_data.map do |attrs|
  organiser.venues.create!(attrs)
end

# Create 20 events: some this week, some next week
today       = Date.today
this_week   = (today..(today + 6.days)).to_a
next_week   = ((today + 7.days)..(today + 13.days)).to_a
event_dates = this_week + next_week

20.times do
  date = event_dates.sample
  time = Faker::Time.between_dates(from: date, to: date, period: :evening)
  Event.create!(
    user:        organiser,
    venue:       venues.sample,
    title:       "#{Faker::Music.genre} Night at #{venues.sample[:name]}",
    description: Faker::Lorem.paragraph(sentence_count: 3),
    date:        date,
    time:        time,
    max_slots:   rand(5..20)
  )
end

# Create 10 bookings for the musician
events = Event.all.to_a
events.sample(10).each do |event|
  Booking.create!(
    user:    musician,
    event:   event,
    status:  %w[pending accepted declined].sample,
    message: Faker::Lorem.sentence(word_count: 8)
  )
end

puts "✅ Seeded #{User.count} users, #{Venue.count} venues, #{Event.count} events, #{Booking.count} bookings."
