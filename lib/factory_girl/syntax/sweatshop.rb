class Factory
  module Syntax

    # Extends ActiveRecord::Base to provide sweatshop-like
    # methods for factories.
    #
    # Usage:
    #
    #   require 'factory_girl/syntax/sweatshop'
    #
    #   Factory.define :user do |factory|
    #     factory.name 'Billy Bob'
    #     factory.email 'billy@bob.example.com'
    #   end
    #
    #   # Creates a saved instance without raising (same as saving the result
    #   # of Factory.build)
    #   User.generate(:name => 'Johnny')
    #   User.gen(:name => 'Johnny')
    #
    #   # Creates a saved instance and raises when invalid (same as
    #   # Factory.create)
    #   User.generate!
    #   User.gen!
    #
    #   # Creates an unsaved instance (same as Factory.build)
    #   User.make
    #
    # This syntax was derived from DataMapper's dm-sweatshop
    
    module Sweatshop
      module ActiveRecord #:nodoc:

        def self.included(base) # :nodoc:
          base.extend ClassMethods
        end

        module ClassMethods #:nodoc:

          def generate(overrides = {})
            instance = Factory.build(name.underscore, overrides)
            instance.save
            instance
          end
          alias :gen :generate

          def generate!(overrides = {})
            Factory.create(name.underscore, overrides)
          end
          alias :gen! :generate!

          def make(overrides = {})
            Factory.build(name.underscore, overrides)
          end

        end

      end
    end
  end
end

ActiveRecord::Base.send(:include, Factory::Syntax::Sweatshop::ActiveRecord)
