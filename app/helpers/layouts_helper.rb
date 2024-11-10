# frozen_string_literal: true

module LayoutsHelper
  def sidebar(&block)
    content_tag :nav, capture(&block)
  end

  def sidebar_item(icon_name, title, path: nil)
    content_tag :li, class: "#{current_class?(path)} sidebar-item" do
      link_to path do
        icon(icon_name) + content_tag(:span, title)
      end
    end
  end

  def action_buttons(&block)
    action_buttons_content = capture(&block)
    return if action_buttons_content.blank?

    content_tag :div, class: 'action-buttons' do
      content_tag :div, action_buttons_content, class: 'pull-right'
    end
  end

  def action_button(title, path, options = {})
    link_to title, path, class: options[:class], data: options[:data]
  end

  def panel(title, options = {}, &block)
    content_tag :div, class: "panel #{options[:class]}" do
      content_tag(:h3, title, class: 'panel-title') + capture(&block)
    end
  end
end
