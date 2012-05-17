class Logger

	attr_reader :messages

	def initialize
		@messages = []
	end

	def log_it(message)
		puts "before #{message}"
		yield
		puts "after #{message}"
	end

end

@logger = Logger.new

@logger.log_it "The stuff happened" do
	10.times do 
		puts "it's happening"
	end
end
