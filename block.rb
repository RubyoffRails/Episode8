 class Logger
   
   attr_reader :messages

   def initialize
   	@messages = []
   end

   def log_it(message)
   	puts "before #{message}"
   	yield
   	puts "after  #{message}"
   	#@messages << message  	 end

end

@logger = Logger.new

@logger.log_it "The stuff happened" do
	puts "it's going to happen"
end

#@logger.messages.each do |msg|
#	puts msg
#end