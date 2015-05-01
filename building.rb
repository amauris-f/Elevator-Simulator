class Building
	attr_reader :number_of_elevators, :number_of_floors, :elevators, :floors
	@persons
	@elevators
	@floors
	def initialize(params = {})
		@number_of_floors = params[:number_of_floors]
		@number_of_elevators = params[:number_of_elevators]
		@persons = params[:persons]
		@elevators = Array.new
		@floors = Array.new
		@@simulation.register(self)
		create_elevators
		create_floors
		@persons.each do |person| @@simulation.register(person) end
	end

	def create_floors
		number_of_floors.times do |flr_num|
			floors[flr_num] = Floor.new(flr_num, @persons)
		end
	end

	def create_elevators		
		number_of_elevators.times do |elv_num|
			elevators[elv_num] = Elevator.new()
		end
	end

	def to_s
		@build_s = ""
		(number_of_floors-1).downto(0) do |flr_num|
			@build_s += "Floor: #{flr_num} "
			elevators.each do |elv|
				@build_s += elv.print_elv(flr_num)
			end
			print_floors(flr_num)
		end
		return @build_s
	end

	def print_floors(flr_num)
		@build_s += floors[flr_num].floor_info
		@build_s += "\n"
		9.times do @build_s += " " end
		(number_of_elevators * 5).times do @build_s += "-" end
		@build_s += "\n"
	end

	def clock_tick(params = {})
		puts self
	end
end