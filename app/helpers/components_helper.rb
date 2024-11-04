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

  def table(options = {}, &block)
    Builders::TableBuilder.new(self, options, &block).render
  end
end
