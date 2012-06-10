class DB
  attr_accessor :starting_point, :preview_a, :preview_b, 
                :option_a_id, :option_b_id,
                :content, :winner, :conclusion, :id
                
  @@id = 0     
  @@pages = []
           
  def initialize(hash)
    @@id = @@id + 1
    @id = @@id
    @option_a_id = hash.fetch(:option_a_id)
    @option_b_id = hash.fetch(:option_b_id)    
    @starting_point = hash.fetch(:starting_point)
    @preview_a = hash.fetch(:preview_a)
    @preview_b = hash.fetch(:preview_b)
    @content = hash.fetch(:content)
    @winner = hash.fetch(:winner)
    @conclusion = hash.fetch(:conclusion)
  end

  def self.add_page(page)
    @@pages << page
  end
  
  def self.pages
    @@pages
  end
    
  def self.starting_point
    pages.each do |page|
      return page if page.starting_point == true
    end
  end

  def self.page_with_id(id)
    pages.each do |page|
      return page if page.id == id
    end
  end

end


