require 'active_support'
module Gendarme
	extend ActiveSupport::Concern
	autoload :Configuration, 'gendarme/configuration'
	autoload :Gendarme     , 'gendarme/gendarme'
	end

