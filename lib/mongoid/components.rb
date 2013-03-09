# encoding: utf-8
require "mongoid/changeable"
require "mongoid/findable"
require "mongoid/indexable"
require "mongoid/inspectable"
require "mongoid/reloadable"
require "mongoid/scopable"
require "mongoid/shardable"

module Mongoid
  module Components
    extend ActiveSupport::Concern

    # All modules that a +Document+ is composed of are defined in this
    # module, to keep the document class from getting too cluttered.
    included do
      extend ActiveModel::Translation
      extend Findable
    end

    include ActiveModel::Conversion
    include ActiveModel::ForbiddenAttributesProtection
    include ActiveModel::Naming
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml
    include Atomic
    include Changeable
    include Attributes
    include Evolvable
    include Fields
    include Hierarchy
    include Indexable
    include Inspectable
    include Matchers
    include NestedAttributes
    include Persistence
    include Relations
    include Reloadable
    include Scopable
    include Sessions
    include Serialization
    include Shardable
    include State
    include Threaded::Lifecycle
    include Timestamps::Timeless
    include Validations
    include Callbacks
    include Copyable
    include Equality

    MODULES = [
      Atomic,
      Attributes,
      Callbacks,
      Copyable,
      Changeable,
      Evolvable,
      Fields,
      Hierarchy,
      Indexable,
      Inspectable,
      Matchers,
      NestedAttributes,
      Persistence,
      Relations,
      Reloadable,
      Scopable,
      Serialization,
      Sessions,
      Shardable,
      State,
      Threaded::Lifecycle,
      Timestamps::Timeless,
      Validations,
      Equality
    ]

    class << self

      # Get a list of methods that would be a bad idea to define as field names
      # or override when including Mongoid::Document.
      #
      # @example Bad thing!
      #   Mongoid::Components.prohibited_methods
      #
      # @return [ Array<Symbol> ]
      #
      # @since 2.1.8
      def prohibited_methods
        @prohibited_methods ||= MODULES.flat_map do |mod|
          mod.instance_methods.map{ |m| m.to_sym }
        end
      end
    end
  end
end
