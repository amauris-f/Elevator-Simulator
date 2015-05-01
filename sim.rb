require 'thread'
require './elevator.rb'
require './simulate.rb'
require './person.rb'
require './floor.rb'
require './building.rb'

@@simulation = Simulate.new()
persons = Array.new()
10.times do
  	start = rand(0..4)
	dest = rand(0..4)
  while (dest == start)
  	dest = rand(0..4)
  end
  	person = Person.new(start, dest)
	persons.push(person)
end
# persons.each do |person|
# 	puts "#{person.start}, #{person.destination}"
# end
build_test = Building.new(:number_of_elevators => 1, :number_of_floors => 5, :persons => persons)
@@simulation.run(20)