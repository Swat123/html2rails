require 'html2rails'
require 'html2slim'
namespace :html2rails do
  task :convert_to_slim, [:input_file_name] do |input_file_name|
    output_file_name = input_file_name.sub(".erb",".slim")
    File.open(output_file_name,'w') do |file|
      file << HTML2Slim.convert!(Html2rails.convert!(input_file_name),:erb).to_s
    end

  end
end