# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

blue = Pill.create(
    name: "Blue",
    count: 5
)

Schedule.create(
    pill: blue,
    time: 100,
    day0: 0,
    day1: 1,
    day2: 0,
    day3: 1,
    day4: 0,
    day5: 1,
    day6: 0,
)

Schedule.create(
    pill: blue,
    time: 500,
    day0: 1,
    day1: 1,
    day2: 1,
    day3: 1,
    day4: 1,
    day5: 1,
    day6: 1,
)

Schedule.create(
    pill: blue,
    time: 300,
    day0: 1,
    day1: 2,
    day2: 2,
    day3: 1,
    day4: 1,
    day5: 1,
    day6: 1,
)

red = Pill.create(
    name: "Red Pill",
    count: 420
)

Schedule.create(
    pill: red,
    time: 400,
    day0: 0,
    day1: 0,
    day2: 0,
    day3: 2,
    day4: 0,
    day5: 0,
    day6: 0,
)

p = Pill.create(
  name: 'Ibuprofen',
  count: 500
)

q = Pill.create(
  name: 'Zyrtec',
  count: 500
)

Schedule.create(
  time: 24 * 60 / 2,
  day0: 1,
  day1: 2,
  day2: 1,
  day3: 1,
  day4: 1,
  day5: 1,
  day6: 1,
  pill: p,
  active: true
)

Schedule.create(
  time: 24 * 60 / 2 - 1,
  day0: 1,
  day1: 2,
  day2: 1,
  day3: 1,
  day4: 1,
  day5: 1,
  day6: 1,
  pill: q,
  active: true
)

