module PgForeignKeys::Core
  extend ActiveSupport::Concern

  included do
    validate :validate_foreign_keys
    pg_foreign_keys.each do |foreign_key|
      association_name  = foreign_key.to_s.gsub(/_ids$/, '').pluralize
      entity_name       = association_name.singularize
      foreign_key_table = association_name

      define_method "#{association_name}" do
        foreign_key_table.titleize.singularize.constantize.where(id: send(foreign_key))
      end

      define_method "#{foreign_key}" do
        send("#{foreign_key}_before_type_cast").blank? ? [] : read_attribute(foreign_key)
      end

      define_method "#{foreign_key}=" do |ids|
        write_attribute(foreign_key, ids.uniq.reject(&:blank?))
      end

      define_method "#{entity_name}_list=" do |names|
        names = names.split(',') if names.is_a?(String)
        send("#{foreign_key}=", foreign_key_table.titleize.singularize.constantize.where(name: names).collect(&:id))
      end

      define_method "#{entity_name}_list" do
        send("#{entity_name}_lists").join(',')
      end

      define_method "#{entity_name}_lists" do
        send(association_name).collect(&:name)
      end
    end

    private
    def validate_foreign_keys
      self.class.pg_foreign_keys.each do |foreign_key|
        errors.add(foreign_key, "are not valid") if send(foreign_key).sort != send(foreign_key.to_s.gsub(/_ids$/, '').pluralize).collect(&:id).sort
      end
    end
  end

  module ClassMethods
  end  
end