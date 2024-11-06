# frozen_string_literal: true

class Builders::TableBuilder < Builders::Base
  def render
    content_tag :table, class: 'table' do
      capture(self, &block)
    end
  end

  def header(&block)
    header_content = capture(&block) if block_given?
    content_tag :thead do
      content_tag :tr, header_content
    end
  end

  def body(collection: [], &block)
    content_tag :tbody do
      rows = collection.each_with_index do |item, index|
        concat content_tag(:tr, capture(item, index, &block)) if block_given?
      end

      rows.presence || content_tag(:caption, empty_message, class: 'text-center', align: :bottom)
    end
  end

  private

  def empty_message
    options[:empty_message].presence || 'No records found!'
  end
end
