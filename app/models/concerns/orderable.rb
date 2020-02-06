module Orderable
  extend ActiveSupport::Concern

  module ClassMethods
    def order_by(column, direction)
      signature = "order_by_#{column}"
      if respond_to?(signature)
        public_send(signature, direction.to_s)
      else
        order(column => direction)
      end
    end
  end
end
