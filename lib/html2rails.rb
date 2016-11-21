require "html2rails/version"
require 'html2rails/html_converter'

module Html2rails
  def self.convert!(input)
    HTMLConverter.new(input).to_s
  end

  if defined?(Rake) && defined?(Rails)
    class MyRailtie < Rails::Railtie
      rake_tasks do
        load 'lib/tasks/html2rails.rake'
      end
    end
  end
end
