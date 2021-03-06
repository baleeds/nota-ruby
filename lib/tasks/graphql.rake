# frozen_string_literal: true

require 'graphql/rake_task'

GraphQL::RakeTask.new(
  dependencies: [:environment],
  schema_name: 'NotaSchema',
  directory: 'app/graphql'
)
