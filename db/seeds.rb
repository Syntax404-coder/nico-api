# db/seeds.rb
# Matchpoint API seed data
# Design rules: No emojis, solid colors only, PH locations

Message.delete_all
Match.delete_all
Swipe.delete_all
Photo.delete_all
User.delete_all

# Reset primary key sequences for Postgres
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('photos')
ActiveRecord::Base.connection.reset_pk_sequence!('swipes')
ActiveRecord::Base.connection.reset_pk_sequence!('matches')

# Create Admin
admin = User.find_or_create_by!(email: "admin@matchpoint.com") do |u|
  u.first_name = "Admin"
  u.last_name = "User"
  u.password = "password123"
  u.birthdate = "1990-01-01"
  u.gender = "Other"
  u.gender_interest = "Both"
  u.country = "Philippines"
  u.province = "Metro Manila"
  u.city = "Makati"
  u.mobile = "09170000000"
  u.bio = "Matchpoint administrator account."
  u.role = "admin"
end

puts "[SEED] Admin: #{admin.email}"

# Create Male User - Nico
nico = User.find_or_create_by!(email: "nico@matchpoint.com") do |u|
  u.first_name = "Nico"
  u.last_name = "Santos"
  u.password = "password123"
  u.birthdate = "1998-05-15"
  u.gender = "Male"
  u.gender_interest = "Female"
  u.country = "Philippines"
  u.province = "Metro Manila"
  u.city = "Taguig"
  u.mobile = "09171234567"
  u.bio = "Looking for meaningful connections."
  u.role = "user"
end

puts "[SEED] Male User: #{nico.email}"

# Create Female User - Louise
louise = User.find_or_create_by!(email: "louise@matchpoint.com") do |u|
  u.first_name = "Louise"
  u.last_name = "Reyes"
  u.password = "password123"
  u.birthdate = "1999-08-20"
  u.gender = "Female"
  u.gender_interest = "Male"
  u.country = "Philippines"
  u.province = "Cebu"
  u.city = "Cebu City"
  u.mobile = "09181234567"
  u.bio = "Exploring new connections."
  u.role = "user"
end

puts "[SEED] Female User: #{louise.email}"

puts "[SEED] Seeding complete! Created #{User.count} users."
