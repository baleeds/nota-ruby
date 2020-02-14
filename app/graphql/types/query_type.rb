module Types
  class QueryType < Types::BaseObject
    field :users, resolver: UsersQuery
    field :user, resolver: UserQuery
    field :me, resolver: MeQuery
    field :annotation, resolver: AnnotationQuery
    field :annotations, resolver: AnnotationsQuery
    field :my_annotations, resolver: MyAnnotationsQuery
    field :verse, resolver: VerseQuery
  end
end
