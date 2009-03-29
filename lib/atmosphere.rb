class Atmosphere  
  
  attr_reader :word_count
  
  def initialize(command)
    @word_count = {}
    if !command.nil?
      fhi = IO.popen(command)
      while (line = fhi.gets)
        extract_words(line)
      end
    end
  end
  
  def extract_words(path)
    file_name = file_name(path)
    words = file_name.split(/\.|_|(?=[A-Z])/)
    words = words.map { |item|  item.downcase.chomp}
    words.delete_if {|word| word.length == 1 }
    add_words(words)
    return words
  end
  
  def build_cloud
    cloud = Cloud.new(@word_count)
    return cloud
  end
  
  private
  
  def add_words(words)
    words.each do |word|
      if @word_count.include? word
        @word_count[word] = @word_count[word]+1 
      else
        @word_count[word] = 1
      end
    end
  end
  
  def file_name(path)
    path_tokens = path.split("/")
    if path_tokens.find_all {|i|  i[0,1] == "." }.length == 0
      file = path_tokens.last
      if file.include? "."
        return file
      end
    end
     return ""
  end
  
end