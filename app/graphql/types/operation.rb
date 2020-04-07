# frozen_string_literal: true

module Types
  module Operation
    extend ActiveSupport::Concern

    included do
      resolve_method :resolver
    end

    attr_reader :input

    delegate :can_access?, to: :class

    def resolver(**args)
      @input = OpenStruct.new(args)
      rescue_resolver do
        if respond_to?(:authorized_resolve)
          authorize
          authorized_resolve
        else
          resolve
        end
      end
    end

    def resolve; end

    def authorize(record = nil)
      return if can_access?(current_user, record)

      if current_user.guest?
        NotaSchema.authenticated_error
      else
        NotaSchema.authorized_error
      end
    end

    def current_user
      context[:current_user]
    end

    private

    def rescue_resolver
      yield
    rescue ::ActiveRecord::RecordNotFound
      NotaSchema.record_not_found_error
    end

    class_methods do
      attr_reader :policy_class, :policy_method

      def policy(policy_class, policy_method)
        @policy_class = policy_class
        @policy_method = policy_method
      end

      def can_access?(current_user, record = nil)
        policy_class.new(current_user, record).send(policy_method)
      end
    end
  end
end
