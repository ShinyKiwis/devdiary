# frozen_string_literal: true

module ComponentsHelper
  def footer_modal(modal_type, title, message)
    icon_name = modal_type == 'success' ? 'check-circle-fill' : 'exclamation-triangle-fill'
    content_tag :div, data: { controller: 'footer-modal' }, class: "footer-modal footer-#{modal_type}" do
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

  def editor(id, options = {})
    content_tag(:div, nil, id: id, class: 'editor', data: { controller: 'editor', editor_content: options[:content] })
  end

  def previewer(attachments)
    return content_tag(:small, 'No attachments provided!') if attachments.blank?

    content_tag(:div, class: 'previewer', data: { controller: 'previewer' }) do
      attachments.each do |attachment|
        concat(content_tag(:div, class: 'preview-item') do
          concat image_tag(attachment, data: { id: attachment.signed_id })
        end)
        concat(modal(title: attachment.filename, id: attachment.signed_id) do
          image_tag(attachment)
        end)
      end
    end
  end

  def modal(options, &block)
    content_tag(:div, id: options[:id], class: 'modal-overlay hidden', data: { controller: 'modal', action: 'click->modal#close' }) do
      concat(content_tag(:div, class: 'modal') do
        concat(content_tag(:div, class: 'modal-header') do
          concat(content_tag(:h2, options[:title]))
          concat(content_tag(:button, icon('x'), class: 'close-modal', data: { action: 'click->modal#close' }))
        end)
        concat(content_tag(:div, class: 'modal-content') do
          capture(&block)
        end)
      end)
    end
  end
end
