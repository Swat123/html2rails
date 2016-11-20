require 'nokogiri'
module Html2rails
  class HTMLConverter
    def initialize(file)
      html = File.exists?(file) ? open(file).read : file
      html_doc = Nokogiri::HTML(html,&:noblanks)

      traverse_recursively(html_doc)

      html = html_doc.to_xhtml(indent:3)
      @erb  = convert_meta_to_erb(html)
    end

    def to_s
      @erb
    end

    def convert_meta_to_erb html
      html.split("\n").map do |line|
        if(line.strip.start_with?('<html2rails-'))
          CGI.unescapeHTML line.split('html2rails-txt="')[1].split('"')[0]
        else
          line
        end
      end.join("\n")
    end

    def traverse_recursively node
      node.children.each do |child|
        traverse_recursively child
        case child.name
          when 'img'
            child.name = 'html2rails-img'
            attributes = {}
            child.attributes.each do |attr,value|
              attributes[attr] = value
              child.delete attr
            end
            src = attributes.delete('src')
            if attributes.length > 0
              child['html2rails-txt'] = "<%= image_tag(\"#{src}\", #{attributes.map{|k,v| ":"+k+" => \""+v+"\""}.join(', ')}) %>"
            else
              child['html2rails-txt'] = "<%= image_tag(\"#{src}\") %>"
            end

          when 'link'
            attributes = {}
            child.attributes.each do |attr,value|
              attributes[attr] = value
            end
            href = attributes.delete 'href'

            attributes.delete 'rel'
            child.name = 'html2rails-link'
            attributes.each do |k,_|
              child.delete k
            end

            if attributes.length > 0
              child['html2rails-txt'] = "<%= stylesheet_link_tag(\"#{href}\", #{attributes.map{|k,v| ":"+k+" => \""+v+"\""}.join(', ')}) %>"
            else

              child['html2rails-txt'] = "<%= stylesheet_link_tag(\"#{href}\") %>"
            end

        end
      end
    end
  end
end