class Elevator 
	attr_reader :position, :direction, :passengers, :button_pickups
	@@button_calls = Array.new()
	@dest_queue
	@stopped
	def initialize()
		@button_pickups = Array.new()
		@position = 0
		@passengers = Array.new()
		@dest_queue = Array.new()
		@@simulation.register(self)
	end

	def self.button_call(flr_call)
		if !@@button_calls.include?(flr_call)
			@@button_calls.push(flr_call)
			@@button_calls.sort!
		end
	end

	def move(next_dest)
		@pos = false
		first_dest = next_dest[0]
		if position < first_dest
			@position += 1
		elsif position > first_dest
			@position -= 1
		end
	end

	def enter(person)
		@passengers.push(person)
	end

	def exit(person)
		@passengers.delete(person)
	end

	def print_elv(flr_num)
		if flr_num == position
			return " [#{passengers.size}] "
		else
			return "     "
		end
	end

	def clock_tick(params = {})
		floor_calls?
				stop?()
		if !@dest_queue.empty?
			unless @stopped then move(@dest_queue) end
		elsif !@button_pickups.empty?
			unless @stopped then move(@button_pickups) end
		else 
			rest_floor
		end
		open_if_needed
	end

	def open_if_needed
		dest = @dest_queue[0] 
		if position == @button_pickups[0]
			add_to_queue
			@button_pickups.shift
		elsif position == dest
	 		@dest_queue.shift
	 	end
	end

	def stop?()
		if position == @button_pickups[0] || position == @dest_queue[0]
			@stopped = true
		else
			@stopped = false
		end
	end

	def floor_calls?
		if !@@button_calls.empty?
			@button_pickups.push(@@button_calls.shift()) 
		end
	end

	def add_to_queue
		@dest_queue.sort_by! {|person| (person - position).abs}
	end	

	def rest_floor
		if position != 0 
			@position = @position - 1
		end
	end

	def go_to(dest)
		if !@dest_queue.include?(dest)
			@dest_queue.push(dest)
		end
	end
end