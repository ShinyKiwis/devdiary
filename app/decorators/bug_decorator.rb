# frozen_string_literal: true

class BugDecorator < ApplicationDecorator
  def formatted_result(result)
    if object.open?
      content_tag(:small, 'Waiting for investigation!')
    elsif object.in_progress?
      content_tag(:small, 'Investigating!')
    elsif object.resolved?
      result.presence || content_tag(:small, 'No given result!')
    end
  end

  def formatted_field_info(info)
    info.presence || content_tag(:small, 'Not available! Considering to update!')
  end
end
