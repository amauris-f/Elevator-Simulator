# Elevator-Simulator
<a href="https://codeclimate.com/github/amfer17/Elevator-Simulator"><img src="https://codeclimate.com/github/amfer17/Elevator-Simulator/badges/gpa.svg" /></a>
<br>


A Simulator class along with a few other classes, that represents elevators in a building.

##Classes
###Person
The Person class creates a person with a starting floor position, and a destination floor.

```Ruby
person = Person.new(0, 4) #A person is created who is on the ground floor, 
                          #who wants to get to the fourth floor. 
```

###Building
The Building class creates a building with floors and elevators.To initialize a building, the number of floors, number of elevators, and an array of Person instances are required.
```Ruby
  building = Building.new(:number_of_elevators => 1, :number_of_floors => 5, :persons => persons)
```
When initialized, the building itself will create instances of Elevator and Floor to represent its own elevators and floors.

###Elevator
The Elevator class creates an elevator. The Elevator class functions in a way so that when it is initialized by the building, it does not need to know the number of floors. Thus,
it does not need any arguments when initialized. I created the Elevator class to have a class variable that is recognized across
all instances of the class. This class variable represents a queue that contains the button calls from each floor. Every instance will obtain an instance
call that will not be viewedby other elevators, so that no two elevators go for the same floor. This also allows the calls to be distributed across all
elevators.
```Ruby
elv = Elevator.new()
```

###Floor
The Floor class creates a floor that is assigned to what floor number it has, and an array of Person instances that are on the floor, waiting for
an elevator.
```Ruby
first_floor = Floor.new(0, persons) #There are people on the ground(0th) floor
```
###Simulate
The Simulate class runs the whole simulation of the elevators. In order to do so, when any instance of the previous classes initializes,
these instances register themselves to the simulation. Thus, an instance of the Simulate class should be the first of these classes
to be initialized, so that the other classes can have a simulation instance to register to. After the Simulate class, the person instances
should be initialized, followed by an instance of a Building class.
```Ruby
@@simulation = Simulate.new()
```
The simulation instance is set to a global variable, so that all instances of any object can recognize it.


##Simulation Example
simul.rb will create a building with one elevator and five floors, as well as a Simulate instance set as @@simulation. 10 instances of the Person object are created and 
inserted into the building. Once every object is registered to @@simulation, the run function from simulation is called. The run function
takes a number as an argument that will represent the number of 'ticks'.
```ruby
@@simulation.run(20) #20 'ticks'
```
Ticks represent steps, where for each step, every instance that has registered itself to @@simulation will
be checked to see if any action is required. For example, on one tick, an elevator might move up to the next floor. In the next tick
the elevator will take in people that are on that floor. On the next tick, the elevator will move one step towards wherever its 
next destinaion is. Another example of ticks involve instances of the Person class, which are also registered to the simulation. For several ticks,
a person might not do anything at all, until an elevator reaches the floor that the person is on. Once this happens, a tick on
the person will lead the person to enter the elevator. All classes have a clock_tick function, which is called by @@simulation while
it is running for every tick. For every class, the clock_tick method functions differently. Each time there is a tick, 
the Building instance's clock_tick method will print out a small printout of the building to show the progression of the elevators
throughout the simulation.
