module LedermannRailsSettings
  module Scopes
    def with_settings
      result = joins("INNER JOIN #{base_class.table_name} ON #{settings_join_condition}")

      if ActiveRecord::VERSION::MAJOR < 5
        result.uniq
      else
        result.distinct
      end
    end

    def with_settings_for(var)
      raise ArgumentError.new('Symbol expected!') unless var.is_a?(Symbol)
      joins("INNER JOIN #{base_class.table_name} ON #{settings_join_condition} AND #{base_class.table_name}.var = '#{var}'")
    end

    def without_settings
      joins("LEFT JOIN #{base_class.table_name} ON #{settings_join_condition}").
      where('settings.id IS NULL')
    end

    def without_settings_for(var)
      raise ArgumentError.new('Symbol expected!') unless var.is_a?(Symbol)
      joins("LEFT JOIN #{base_class.table_name} ON  #{settings_join_condition} AND #{base_class.table_name}.var = '#{var}'").
      where("#{base_class.table_name}.id IS NULL")
    end

    def settings_join_condition
      "#{base_class.table_name}.target_id   = #{table_name}.#{primary_key} AND
       #{base_class.table_name}.target_type = '#{base_class.name}'"
    end
  end
end
