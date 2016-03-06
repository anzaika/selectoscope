module ActiveType
  module Util

    def cast(object, klass)
      if object.is_a?(ActiveRecord::Relation)
        cast_relation(object, klass)
      elsif object.is_a?(ActiveRecord::Base)
        cast_record(object, klass)
      else
        raise ArgumentError, "Don't know how to cast #{object.inspect}"
      end
    end

    def scoped(klass_or_relation)
      klass_or_relation.where(nil)
    end

    private

    def cast_record(record, klass)
      # record.becomes(klass).dup
      klass.new do |casted|
        # Rails 3.2, 4.2
        casted.instance_variable_set(:@attributes, record.instance_variable_get(:@attributes))
        # Rails 3.2
        record.instance_variable_set(:@attributes_cache, record.instance_variable_get(:@attributes_cache))
        # Rails 4.2
        casted.instance_variable_set(:@changed_attributes, record.instance_variable_get(:@changed_attributes))
        # Rails 3.2, 4.2
        casted.instance_variable_set(:@new_record, record.new_record?)
        # Rails 3.2, 4.2
        casted.instance_variable_set(:@destroyed, record.destroyed?)
        # Rails 3.2, 4.2
        casted.instance_variable_set(:@errors, record.errors)
      end
    end

    def cast_relation(relation, klass)
      scoped(klass).merge(scoped(relation))
    end

    extend self

  end

  # Make Util methods available under the `ActiveType` namespace
  # like `ActiveType.cast(...)`
  extend Util
end
