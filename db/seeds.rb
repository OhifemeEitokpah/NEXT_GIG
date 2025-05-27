# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# db/seeds.rb
require 'faker'

# Clear existing data (optional, but keeps things idempotent)
Booking.delete_all
Event.delete_all
Venue.delete_all
User.delete_all

5.times do
  # 1) Musician
  User.create!(
    name:     Faker::Name.name,
    email:    Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password',
    role:     :musician,
    bio:      Faker::Quote.famous_last_words,
    genre:    Faker::Music.genre
  )

  # 2) Organiser → Venue → Event
  organiser = User.create!(
    name:     Faker::Name.name,
    email:    Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password',
    role:     :organiser,
    bio:      Faker::Lorem.sentence(word_count: 10)
  )

  venue = organiser.venues.create!(
    name:        "#{Faker::Company.name} Open Mic",
    address:     Faker::Address.street_address,
    city:        Faker::Address.city,
    country:     Faker::Address.country,
    description: Faker::Lorem.paragraph(sentence_count: 2)
  )

  Event.create!(
    venue:       venue,
    user:        organiser,
    title:       "#{Faker::Music.genre} Night at #{venue.name}",
    description: Faker::Lorem.paragraph(sentence_count: 3),
    date:        Faker::Date.forward(days: rand(1..30)),
    time:        Faker::Time.forward(days: rand(1..30), period: :evening),
    max_slots:   rand(5..20)
  )
end

puts "✅ Seeded #{User.count} users, #{Venue.count} venues, #{Event.count} events."
