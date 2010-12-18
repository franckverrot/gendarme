module Gendarme
	class Configuration
		class << self
			attr_accessor :log_stream
			def logger=(log)
				self.log_stream = log
			end
			def logger
				self.log_stream
			end
		end
	end
end
