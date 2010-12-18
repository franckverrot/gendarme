module Gendarme
  module Gendarme
    extend ActiveSupport::Concern

    module ClassMethods
      attr_accessor :metadata
      def apply_gendarme_rules(m)
        class_eval do
          alias :"original_#{m}" :"#{m}"
          define_method :"process_preconditions_on_#{m}" do |*args|
            preconditions = self.class.metadata[m][:preconditions]
            method = self.class.instance_method(m)
            preconditions.each_pair do |parameter_position, precondition|
              Configuration.logger.puts "Won't validate a nil parameter##{parameter_position}" if args[parameter_position].nil?
              unless precondition[:block].call(args[parameter_position])
                Configuration.logger.puts "This precondition is false: #{precondition[:message]}"
              end
            end
          end

          define_method :"process_postrelations_on_#{m}" do |result|
            postrelations = self.class.metadata[m][:postrelations]
            postrelations.each_pair do |assertion_number, postrelation|
              expected_assertion = postrelation[:block].call(result)
              unless expected_assertion
                Configuration.logger.puts "This postrelation is false: #{postrelation[:message]}"
              end
            end if postrelations

            result
          end

          define_method(m) do |*args|
            send(:"process_preconditions_on_#{m}", *args)
            result = send(:"original_#{m}", *args)
            send(:"process_postrelations_on_#{m}", result)
          end
        end
        #end
      end

      def clear_metadata
        @__current_preconditions = @__current_postrelations = nil
      end

      def precondition(parameter, message, &block)
        @__current_preconditions ||= {}
        @__current_preconditions[parameter] = { :message => message, :block => block }
      end

      def postrelation(parameter, message, &block)
        @__current_postrelations ||= {}
        @__current_postrelations[parameter]= { :message => message, :block => block }

      end

      def method_added(m)
        @already_processed ||= []

        return if /^(original_|process_)/ =~ m or @already_processed.include?(m)

        @already_processed << m
        @__last_method = m

        self.metadata ||= {}
        self.metadata[@__last_method] = {
          :preconditions => @__current_preconditions,
          :postrelations => @__current_postrelations
        }
        clear_metadata
        apply_gendarme_rules(m)
      end
    end
  end
end
