require 'active_support'
require 'gendarme'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb' ))].each {|f| require f}
			
RSpec.configure do |rspec_config|
end
