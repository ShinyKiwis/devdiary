# frozen_string_literal: true

class Builders::DescriptionTableBuilder < Builders::Base
  def render
    content_tag :table, class: 'description-table' do
      capture(self, &block)
    end
  end

  def line(label, value = nil, classname: nil)
    value ||= capture(&block) if block_given?
    content_tag :tr do
      concat content_tag(:th, label, width: options[:label_width] || 150)
      concat content_tag(:td, value.presence || 'N/A', class: classname)
    end
  end
end
