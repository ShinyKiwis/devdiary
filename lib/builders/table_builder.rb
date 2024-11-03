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
end
