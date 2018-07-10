module RailsSettings
  # In Rails 3, attributes can be protected by `attr_accessible` and `attr_protected`
  # In Rails 4, attributes can be protected by using the gem `protected_attributes`
  # In Rails 5, protecting attributes is obsolete (there are `StrongParameters` only)
  def self.can_protect_attributes?
    (ActiveRecord::VERSION::MAJOR == 3) || defined?(ProtectedAttributes)
  end
end

require 'ledermann-rails-settings/setting_object'
require 'ledermann-rails-settings/configuration'
require 'ledermann-rails-settings/base'
require 'ledermann-rails-settings/scopes'

ActiveRecord::Base.class_eval do
  def self.has_settings(*args, &block)
    LedermannRailsSettings::Configuration.new(*args.unshift(self), &block)

    include LedermannRailsSettings::Base
    extend LedermannRailsSettings::Scopes
  end
end

