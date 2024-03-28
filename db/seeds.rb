# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'

# initialize admin approved
User.create! do |u|
  u.email = 'admin.1@osu.edu'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.first_name = 'fname'
  u.last_name = 'lname'
  u.role = 2
  u.approved = true
end

# initialize admin pending approval
User.create! do |u|
  u.email = 'admin.2@osu.edu'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.first_name = 'fname'
  u.last_name = 'lname'
  u.role = 2
  u.approved = false
end

# initialize instructor approved
User.create! do |u|
  u.email = 'instructor.1@osu.edu'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.first_name = 'fname'
  u.last_name = 'lname'
  u.role = 1
  u.approved = true
end

# initialize instructor pending approval
User.create! do |u|
  u.email = 'instructor.2@osu.edu'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.first_name = 'fname'
  u.last_name = 'lname'
  u.role = 1
  u.approved = false
end

# initialize student
User.create! do |u|
  u.email = 'student.1@osu.edu'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.first_name = 'fname'
  u.last_name = 'lname'
  u.role = 0
  u.approved = false
end
