class BugDecorator < ApplicationDecorator
  def formatted_result(result)
    case true
    when object.open?
      content_tag(:small, 'Waiting for investigation!')
    when object.in_progress?
      content_tag(:small, 'Investigating!')
    when object.resolved?
      result.presence || content_tag(:small, 'No given result!')
    end
  end
end
