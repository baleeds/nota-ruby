# frozen_string_literal: true

module Outputs
  class UserType < Types::BaseObject
    implements Types::ActiveRecord

    global_id_field :id
    field :email, String, null: false
    field :is_active, Boolean, null: false
    field :is_admin, Boolean, null: false
    field :username, String, null: false
    field :display_name, String, null: false

    def self.loads(id)
      User.find(id)
    end

    def is_active
      @object.active?
    end

    def is_admin
      @object.admin?
    end
  end
end
