require "html2rails/version"
require 'html2rails/html_converter'

module Html2rails
  def self.convert!(input)
    HTMLConverter.new(input).to_s
  end
end
