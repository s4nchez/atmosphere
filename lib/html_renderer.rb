require 'erb'

class HtmlRenderer

  def render(cloud, file)
    template = ""
    
    File.open("html_template.html.erb", "r") do |infile|
         while (line = infile.gets)
              template << line
          end
    end

    @words = cloud.give_me_words(50, 10, 60)
    @words.replace @words.sort_by { rand }
    
    File.open(file, "w") do |f|
      f.puts ERB.new(template).result(binding)
    end
    
  end
end