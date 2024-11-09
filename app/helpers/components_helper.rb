# frozen_string_literal: true

module ComponentsHelper
  def footer_modal(modal_type, title, message)
    icon_name = modal_type == 'success' ? 'check-circle-fill' : 'exclamation-triangle-fill'
    content_tag :div, data: { controller: 'modal' }, class: "footer-modal footer-#{modal_type}" do
      icon(icon_name) + content_tag(:div, '', class: 'footer-content') do
        concat content_tag(:p, title)
        concat content_tag(:p, message)
      end
    end
  end

  def accordion(title: 'Empty title', &block)
    content_tag :div, class: 'accordion', data: { controller: 'accordion' } do
      concat(content_tag(:div, class: 'accordion-title', data: { accordion_target: 'title', action: 'click->accordion#toggle' }) do
        concat content_tag(:h3, title)
        concat icon('chevron-down')
      end)
      concat(content_tag(:div, class: 'accordion-body', data: { accordion_target: 'content' }) do        
        content_tag(:div) do
          content_tag(:div, capture(&block), class: 'accordion-content')
        end
      end)
    end
  end

  def table(options = {}, &block)
    Builders::TableBuilder.new(self, options, &block).render
  end

  def description_table(options = {}, &block)
    Builders::DescriptionTableBuilder.new(self, options, &block).render
  end
end
