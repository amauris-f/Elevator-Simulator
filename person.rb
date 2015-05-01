class Person
	attr_reader :start, :destination

	def initialize(start, destination)
		@start = start
		@destination = destination
		Elevator.button_call(start)
	end

	def clock_tick(params = {})
		elvs = params[:elevators]
		elvs.each do |elv|
			pax = elv.passengers
			if pax.include?(self) && elv.position == destination
				elv.exit(self)
			elsif elv.position == start
				enter_elv(elv)
			end
		end
	end

	def enter_elv(elv)
		elv.enter(self)
		elv.go_to(destination)
		@start = nil
	end

	def to_s
		return "[#{start}, #{destination}]"
	end
end