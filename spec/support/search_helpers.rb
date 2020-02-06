module SearchHelpers
  def reindex_search(resource)
    resource = get_class(resource)
    resource.reindex
    resource.searchkick_index.refresh
  end

  private

  def get_class(resource)
    return resource if resource.is_a?(Class)

    resource.class
  end
end
