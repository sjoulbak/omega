# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.count == 0
  puts 'Seeding the database...'
  user1 = User.create(email: 'test_gebruiker@omega.nl', password: 'test_gebruiker', password_confirmation: 'test_gebruiker')
  user2 = User.create(email: 'test_gebruiker2@omega.nl', password: 'test_gebruiker2', password_confirmation: 'test_gebruiker2')
  User.create(email: 'test_medewerker@omega.nl', password: 'test_medewerker', password_confirmation: 'test_medewerker', admin: true)

  soortcourse = Soortcourse.create(cursussoort: 'Beginnerscursus', prijs: 10)

  course1 = Course.create(begindatum: DateTime.now, einddatum: DateTime.tomorrow, soortcourse: soortcourse)
  course2 = Course.create(begindatum: DateTime.tomorrow, einddatum: DateTime.now + 7.days, soortcourse: soortcourse)

  user1.course_users.create(course: course1)
  user1.course_users.create(course: course2)
  user2.course_users.create(course: course1)
  puts 'Seed complete.'
else
  puts 'Error, cannot seed the database. Users already exists.'
end
