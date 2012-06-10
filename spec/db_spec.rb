require_relative "spec_helper"

describe DB do
  	subject { DB.new(starting_point: true, 
                      preview_a: "30 gold pieces",
                      preview_b: "Bacon Sandwich",
                      option_a_id: 0,
                      option_b_id: 0,                    
                      content: "You wake up on a road. It's foggy and damp. In your bag is 30 gold pieces and a bacon sandwich. Which do you choose?",
                      winner: false,
                      conclusion: false) }

  it "should have a preview a" do            
    subject.preview_a.should eq("30 gold pieces")
  end
  
  it "should not be a winner" do
    subject.winner.should eq(false)
  end
  
  it "should not be the winner" do
    subject.conclusion.should eq(false)
  end
  
  
end
               