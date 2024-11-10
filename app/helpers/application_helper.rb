# frozen_string_literal: true

module ApplicationHelper
  def icon(name)
    content_tag :i, nil, class: "bi bi-#{name}"
  end

  def icon_with_text(name, text)
    content_tag :span, class: 'icon-with-text' do
      icon(name) + text
    end
  end

  def current_class?(path)
    return 'active' if path.present? && request.path.include?(path)

    ''
  end

  def formatted_environment_detail(object, object_version)
    [object.presence&.titleize, object_version.presence].compact.join('-')
  end

  def add_breadcrumb_node(text, path = nil)
    @breadcrumb_nodes ||= []
    @breadcrumb_nodes << { text: text, path: path }
  end

  def breadcrumb_nodes
    @breadcrumb_nodes || []
  end

  def breadcrumbs
    return if breadcrumb_nodes.empty?

    content_tag :ul, class: 'breadcrumbs' do
      breadcrumb_nodes.each_with_index.map do |node, index|
        content_tag :li, class: 'breadcrumb' do
          if index == breadcrumb_nodes.size - 1
            content_tag :span, node[:text], class: 'active'
          else
            link_to(node[:text], node[:path])
          end
        end
      end.join.html_safe
    end
  end

  def status_label(key, style = nil)
    return if key.blank?

    style ||= keyword_to_color(key) || 'primary'
    content_tag :span, key.titleize, class: "status-label label-#{style}"
  end

  def keyword_to_color(key)
    sanitized_key = key.to_s.downcase
    status_by_keys = {
      success: %w(success resolved easy),
      danger: %w(closed hard),
      warning: %w(medium),
    }

    style, _other_keys = status_by_keys.find { |_, keys| keys.include?(sanitized_key) }
    style
  end

  def environment_icons
    {
      windows: 'windows',
      macos: 'apple',
      linux: 'ubuntu',
      android: 'android',
      ios: 'apple',
      firefox: 'browser-firefox',
      chrome: 'browser-chrome',
      safari: 'browser-safari',
    }.with_indifferent_access
  end

  def environment_detail_with_icon(platform, platform_version)
    return nil if platform.blank? && platform_version.blank?

    icon_with_text(environment_icons[platform], formatted_environment_detail(platform, platform_version))
  end

  def quill_delta_to_html(deltaOps)
    return if deltaOps.blank?

    content_tag :div, data: {controller: 'delta-converter'} do
      deltaOps
    end
  end
end
