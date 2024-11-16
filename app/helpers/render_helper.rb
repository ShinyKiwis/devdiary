# frozen_string_literal: true

module RenderHelper
  def render_pagination(collection, options = {})
    total_count = collection.total_count
    return if collection.total_pages == 1

    render partial: 'shared/pagination', locals: { collection: collection, total_count: total_count }
  end
end
