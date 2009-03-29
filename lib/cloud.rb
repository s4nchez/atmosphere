class Cloud
  
  attr_accessor :filter
  
  def initialize(elements)
    @elements = elements
    @filter = []
  end
    
  def give_me_words(amount, min, max)
    sorted = @elements.sort {|a,b| b[1] <=> a[1]}
    sorted.delete_if {|word| @filter.include? word[0]}
    result = sorted[0..(amount - 1)]
    parametrise(result, min, max)
  end
  
  private 
  
  def parametrise(words, min, max)
    amin = words.last[1]
    amax = words.first[1]
    words.each { |word| word[1] = (((word[1]-amin) * (max-min)) / (amax-amin) ) + min  }
  end
  
end