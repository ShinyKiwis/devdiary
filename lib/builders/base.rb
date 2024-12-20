# frozen_string_literal: true

class Builders::Base
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Context
  include Rails.application.routes.url_helpers

  def initialize(view_context, options = {}, &block)
    @view_context = view_context
    @options = options
    @block = block
  end

  delegate :capture, to: :view_context
  delegate :concat, to: :view_context

  private

  attr_reader :view_context
  attr_reader :options
  attr_reader :block
end
