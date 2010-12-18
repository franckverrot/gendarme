require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

class Foo
	include Gendarme::Gendarme

	#Should be OK
	precondition(0,"Bar responds to :to_i")   { |bar|    bar.respond_to? :to_i  }
	#Should not be OK
	precondition(0,"Bar responds to :to_str") { |bar|    bar.respond_to? :to_str  }
	#Should be OK
	postrelation(0,"Result is an integer")    { |result| result.is_a?(Integer) }
	#Should not be OK
	postrelation(0,"Result is a string")      { |result| result.is_a?(String) }
	def foo(bar)
		bar * 2
	end
end

describe "Gendarme" do
	describe "should print to stderr" do
		before(:each) do
			Gendarme::Configuration.logger = $stderr
		end

		it "on failed preconditons and failed preconditions" do
			output = capture(:stdout,:stderr) do
				Foo.new.foo(2)
			end
			output.should == /failed/
		end
	end
end
