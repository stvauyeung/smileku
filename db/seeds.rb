# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times { Fabricate(:user) }
10.times { Fabricate(:story) }
10.times { Fabricate(:ku) }

one = Story.find(1)
one.kus << Ku.find(1)

two = Story.find(2)
two.kus << Ku.find(2)

three = Story.find(3)
three.kus << Ku.find(3)

four = Story.find(4)
four.kus << Ku.find(4)

five = Story.find(5)
five.kus << Ku.find(5)

six = Story.find(6)
six.kus << Ku.find(6)

seven = Story.find(7)
seven.kus << Ku.find(7)

eight = Story.find(8)
eight.kus << Ku.find(8)

nine = Story.find(9)
nine.kus << Ku.find(9)

ten = Story.find(10)
ten.kus << Ku.find(10)

bob = User.find(1)
bob.stories << [ one, two ]
bob.kus << [Ku.find(1), Ku.find(2)]

jane = User.find(2)
jane.stories << [ three, four ]
jane.kus << [Ku.find(3), Ku.find(4)]

kim = User.find(3)
kim.stories << [ five, six ]
kim.kus << [Ku.find(5), Ku.find(6)]

joe = User.find(4)
joe.stories << [ seven, eight ]
joe.kus << [Ku.find(7), Ku.find(8)]

tom = User.find(5)
tom.stories << [ nine, ten ]
tom.kus << [Ku.find(9), Ku.find(10)]