require 'active_record'
require 'pg_foreign_keys/version'
require 'active_support/concern'

module PgForeignKeys
  extend ActiveSupport::Concern

  autoload :Core,             'pg_foreign_keys/core'

  module ClassMethods
    def pg_foreign_keys(*foreign_keys)
      return @pg_foreign_keys if foreign_keys.blank?
      
      @pg_foreign_keys = foreign_keys

      include PgForeignKeys::Core
    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, PgForeignKeys
end