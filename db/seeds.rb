# db/seeds.rb
require 'faker'
require 'open-uri'

puts "🔄 Starting seed process..."

# Clear existing data
Booking.delete_all
Event.delete_all
Venue.delete_all
User.delete_all

puts "🗑️  Cleared existing Bookings, Events, Venues, and Users."

puts "🎤 Creating musician..."
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

puts "✅ Musician created: #{musician.name} (#{musician.email})"

puts "🏢 Creating organiser..."
# Create one organiser
organiser = User.create!(
  name:     'Venue Owner',
  email:    'owner@example.com',
  password: 'password',
  password_confirmation: 'password',
  role:     :organiser,
  bio:      Faker::Lorem.sentence(word_count: 10)
)

puts "✅ Organiser created: #{organiser.name} (#{organiser.email})"

puts "📍 Creating venues in Berlin..."
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

puts "✅ Created #{venues.count} venues."

# Event image URLs
event_image_urls = [
  'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3',
  'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f',
  'https://images.unsplash.com/photo-1468359601543-843bfaef291a',
  'https://images.unsplash.com/photo-1507901747481-84a4f64fda6d',
  'https://images.unsplash.com/photo-1567942712661-82b9b407abbf',
  'https://images.unsplash.com/photo-1507676184212-d03ab07a01bf',
  'https://images.unsplash.com/photo-1522863602463-afebb8886ab2',
  'https://images.unsplash.com/photo-1599467556385-48b57868f038',
  'https://images.unsplash.com/photo-1526478806334-5fd488fcaabc',
  'https://images.unsplash.com/photo-1501612780327-45045538702b',
  'https://images.unsplash.com/photo-1605340406960-f5b496c38b3d',
  'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae',
  'https://images.unsplash.com/photo-1504871283652-485177543d73',
  'https://images.unsplash.com/photo-1508979822114-db019a20d576',
  'https://plus.unsplash.com/premium_photo-1682600420019-bf44716aa917',
  'https://images.unsplash.com/photo-1632054553195-bfd7034fee25',
  'https://images.unsplash.com/photo-1503528108408-87b0d1c2b785',
  'https://images.unsplash.com/photo-1474692295473-66ba4d54e0d3',
  'https://images.unsplash.com/photo-1507808973436-a4ed7b5e87c9',
  'https://images.unsplash.com/photo-1598387993441-a364f854c3e1'
]

puts "📅 Creating 20 events with images..."
# Create 20 events: some this week, some next week
today       = Date.today
this_week   = (today..(today + 6.days)).to_a
next_week   = ((today + 7.days)..(today + 13.days)).to_a
event_dates = this_week + next_week

20.times do |i|
  date = event_dates.sample
  time = Faker::Time.between_dates(from: date, to: date, period: :evening)
  title = "#{Faker::Music.genre} Night at #{venues.sample[:name]}"
  puts "  • Creating event #{i+1}: #{title} on #{date} at #{time.strftime('%H:%M')}"
  event = Event.create!(
    user:        organiser,
    venue:       venues.sample,
    title:       title,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    date:        date,
    time:        time,
    max_slots:   rand(5..20)
  )
  image_url = event_image_urls[i] + "?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&h=600"
  file = URI.parse(image_url).open
  event.photo.attach(io: file, filename: "event_#{i}.jpg", content_type: 'image/jpeg')
  puts "    📸 Attached image to event #{i+1}"
end

puts "✅ Created 20 events."

puts "🎫 Creating 10 bookings..."
# Create 10 bookings for the musician
events = Event.all.to_a
events.sample(10).each do |event|
  status = %w[pending accepted declined].sample
  puts "  • Booking event #{event.id} with status #{status}"
  Booking.create!(
    user:    musician,
    event:   event,
    status:  status,
    message: Faker::Lorem.sentence(word_count: 8)
  )
end

puts "✅ Created #{Booking.count} bookings."
puts "🎉 Seeding complete!"

puts "✅ Seeded #{User.count} users, #{Venue.count} venues, #{Event.count} events, #{Booking.count} bookings."
