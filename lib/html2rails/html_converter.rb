require 'nokogiri'
module Html2rails
  class HTMLConverter
    def initialize(file)
      html = File.exists?(file) ? open(file).read : file
      html_doc = Nokogiri::HTML(html)

      traverse_recursively(html_doc)

      @html = html_doc.to_html
    end

    def to_s
      @html
    end

    def traverse_recursively node
      node.children.each do |child|
        traverse_recursively child
      end
    end
  end
end