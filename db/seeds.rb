# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
puts "Destroying all events…"
Event.destroy_all
puts "Destroying all venues…"
Venue.destroy_all
puts "Destroying all users…"
User.destroy_all

puts "Creating users…"
user1 = User.create(email: "abc@gmail.com",password:"12345",name: "Karlheinz", role: 0, bio:"WTF", genre:"rock")
user2 = User.create(email: "def@gmail.com",password:"67890",name: "MC Ez", role: 1, bio:"IDK", genre:"jazz")

puts "Creating venues…"
venue1 = Venue.create(user_id: user2.id, name: "S036", address: "Kreuzberg", city: "Berlin", country: "Deutschland", description: "sehr gut")
venue2 = Venue.create(user_id: 2, name: "Metropol", address: "Besiktas", city: "Istanbul", country: "Turkey", description: "ganz ok")

puts "Creating events…"
event1 = Event.create(venue_id: 1, title: "mega-party", description: "awesome", date: 11/10/2025, time: "20:00", max_slots: 8)
event2 = Event.create(venue_id: 2, title: "beach party", description: "awesomer", date: 06/31/2026), time: "22:00", max_slots: 4)

