module Loaders
  class AssociationLoader < GraphQL::Batch::Loader
    def initialize(model, association_name)
      @model = model
      @association_name = association_name
    end

    def load(record)
      unless record.is_a?(model)
        raise TypeError, "#{model} loader can't load association for #{record.class}"
      end
      return Promise.resolve(read_association(record)) if association_loaded?(record)

      super
    end

    def cache_key(record)
      record.object_id
    end

    def perform(records)
      preload_association(records)
      records.each { |record| fulfill(record, read_association(record)) }
    end

    private

    attr_reader :model, :association_name

    def preload_association(records)
      ::ActiveRecord::Associations::Preloader.new.preload(records, association_name)
    end

    def read_association(record)
      record.public_send(association_name)
    end

    def association_loaded?(record)
      record.association(association_name).loaded?
    end
  end
end
