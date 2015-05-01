class Simulate
	@registered

	def initialize()
		@registered = Array.new()
	end

	def register(domain_instance) 
		@registered.push(domain_instance)
	end

	def run(num_ticks)
		elevators = @registered[0].elevators
		floors = @registered[0].floors
		num_ticks.times do 
			@registered.each do |domain|
				domain.clock_tick(:elevators => elevators, :floors => floors)
			end	
			puts "\n\n"
		end
	end
end