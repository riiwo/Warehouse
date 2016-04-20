# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
salt = BCrypt::Engine.generate_salt
password_encrypted = BCrypt::Engine.hash_secret('admin', salt)
Worker.new(username: 'admin', admin: 2, email: 'admin@admin.org', password_encrypted: password_encrypted, salt: salt).save(validate: false)
