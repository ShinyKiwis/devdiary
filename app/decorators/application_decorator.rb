# frozen_string_literal: true

class ApplicationDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::OutputSafetyHelper
end
