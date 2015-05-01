class Floor
	@persons
	@left
	@arived
	attr_reader :floor_number, :persons
	def initialize(floor_number, persons)
		@floor_number = floor_number
		@persons = persons_in_floor(persons)
		@@simulation.register(self)
		@left = 0
		@arived = 0
	end	

	def persons_in_floor(persons)
		persons_queue = Array.new()
		persons.each do |person|
			if person.start == floor_number
				persons_queue.push(person)
			end
		end
		return persons_queue
	end

	def clock_tick(params = {})
		elevators = params[:elevators]
		elevators.each do |elv|
			if elv.position == floor_number
				count_arriving(elv)
				unless @left != 0 then @left = @persons.size end
				@persons = Array.new()
			end
		end
	end

	def count_arriving(elv)
		persons_lvng_elv = elv.passengers
		persons_lvng_elv.each do |person|
			if person.destination == floor_number then @arived += 1 end
		end
	end

	def floor_info
		num_persons = @persons.size
		temp_arived = @arived
		temp_left = @left
		@left = 0
		@arived = 0
		return "\t# of Passengers waiting: #{num_persons}, departed: #{temp_left}, arrived: #{temp_arived} "
	end
end