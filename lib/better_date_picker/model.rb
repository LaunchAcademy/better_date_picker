require "active_support"
require "active_model"
require "chronic"

module BetterDatePicker
  module Model
    extend ActiveSupport::Concern

    included do
      extend ClassMethods
      class_attribute :better_date_fields
      class_attribute :better_date_defaults
    end

    module ClassMethods
      def better_date_picker(field, options = {})
        self.better_date_fields ||= []
        self.better_date_defaults ||= {}

        if self.better_date_fields.empty?
          after_validation :propagate_better_date_errors
        end

        define_method "#{field}=" do |date_val|
          #we don't want to clobber the ivar if we're setting via the string
          val_to_set = date_val.nil? ? nil : date_val.strftime(self.class.better_date_format)
          instance_variable_set("@#{field}_date", val_to_set)

          #if the setter is not defined as a method, just set the ivar
          begin
            super(date_val)
          rescue NoMethodError => e
            instance_variable_set("@#{field}", date_val)
          end

        end

        define_method "#{field}_date" do
          string_val = instance_variable_get("@#{field}_date")
          if string_val.nil?
            if the_date = self.send(field)
              the_date.strftime(self.class.better_date_format)
            end
          else
            string_val
          end
        end

        define_method "#{field}_date=" do |stringified_date|
          instance_variable_set("@#{field}_date", stringified_date)
          self.send("#{field}=", Chronic.parse(stringified_date))
          stringified_date
        end

        self.better_date_fields << field
        self.better_date_defaults[field] = options[:default]
      end

      def better_date_format
       "%m/%d/%Y"
      end
    end

    protected
    def propagate_better_date_errors
      if self.class.better_date_fields && !self.class.better_date_fields.empty?
        self.class.better_date_fields.each do |field|
          if self.errors[field].present?
            self.errors[field].each do |error|
              self.errors.add("#{field}_date", error)
            end
          end
        end
      end
    end
  end
end
