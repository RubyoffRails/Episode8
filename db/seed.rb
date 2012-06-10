#require_relative '../spec/spec_helper.rb'
require_relative '../models/db.rb'

start_page = DB.new(starting_point: true, 
                    preview_a: "30 gold pieces",
                    preview_b: "Bacon Sandwich",
                    option_a_id: 0,
                    option_b_id: 0,                    
                    content: "You wake up on a road. It's foggy and damp. In your bag is 30 gold pieces and a bacon sandwich. Which do you choose?",
                    winner: false,
                    conclusion: false)  

DB.add_page(start_page)

choice_1a = DB.new(starting_point: false, 
                   preview_a: "Plunge into the woods",
                   preview_b: "Run down the road toward to bridge",
                   option_a_id: 0,
                   option_b_id: 0,                                    
                   content: "You put the 30 gold pieces in your pocket and toss the bacon sandwich on the ground. A fair maiden emerges from the woods, grabs your sandwich and takes off. You've got to stop her! Where will you go?",
                   winner: false,
                   conclusion: false)                    

DB.add_page(choice_1a)

choice_1b = DB.new(starting_point: false,
                   preview_a: "I think she's heading for the bubbling brook, after her!",
                   preview_b: "Climb the nearest tree and see if you can spot her.",                        
                   option_a_id: 0,
                   option_b_id: 0,                                    
                   content: "As you toss the gold on the ground and begin to eat your bacon sandwich, a fair maiden emerges from the woods and says 'm'lord, can I have the rest of that sandwich?' Before you answer, she grabs the sandwich and takes off. She must be stopped! Where will you go?",
                   winner: false,
                   conclusion: false)                    

DB.add_page(choice_1b)
                        
choice_2a = DB.new(starting_point: false,
                   preview_a: "Well, if the woods didn't work, maybe she's hiding under that bridge down the road.",
                   preview_b: "She is seriously hiding under the bridge down the road. I mean, who checks the woods first? Really. Just go look under the bridge.",
                   option_a_id: 0,
                   option_b_id: 0,                                     
                   content: "You plunge into the woods. There are stickers everywhere. This is not worth a chunky bacon sandwich. Where do you go next?",
                   winner: false,
                   conclusion: false)                    

DB.add_page(choice_2a)

choice_2b = DB.new(starting_point: false,
                   preview_a: "You see the maiden! She's under the bridge. Pounce!",
                   preview_b: "Jump in the warp machine, see a command prompt: <br> $>gem install find_maiden <br> $>irb <br> $>require 'find_maiden' <br> $>m = Maiden.new <br> $>m.throw_net_over_and_get_back_sandwhich",
                   option_a_id: 0,
                   option_b_id: 0,                                     
                   content: "You run down the road and come to a bridge.",
                   winner: false,
                   conclusion: false)                                       

DB.add_page(choice_2b)

choice_2c = DB.new(starting_point: false,
                   preview_a: "Blink twice using your Google glasses to issue the 'Get GPS coordinates of Fair Maiden from your circling UAV' command.",
                   preview_b: "Charge the bridge.",
                   option_a_id: 0,
                   option_b_id: 0,                                     
                   content: "You hear a bubbling brook and follow the sound down the road. You can see a bridge ahead and bread crumbs lay at your feet. What do you do?",
                   winner: false,
                   conclusion: false)                                       

DB.add_page(choice_2c)                   
 
choice_2d = DB.new(starting_point: false,
                   preview_a: "Run quickly to the bridge.",
                   preview_b: "Run at Ent speed for the bridge.",
                   option_a_id: 0,
                   option_b_id: 0,                                     
                   content: "The tree you try to climb is one of those Ents from Lord of the Rings. He ain't happy. After 20 minutes of tense negotiations, he tells you to run down to the bridge.",
                   winner: false,
                   conclusion: false)                                       

DB.add_page(choice_2d)                   
                        
choice_3 =  DB.new(starting_point: false,
                   preview_a: "",
                   preview_b: "",
                   option_a_id: 0,
                   option_b_id: 0,                                     
                   content: "You find the maiden, take back your sandwich and ride off into the sunset.",
                   winner: true,
                   conclusion: true)

DB.add_page(choice_3)  
 
start_page.option_a_id = choice_1a.id
start_page.option_b_id = choice_1b.id

choice_1a.option_a_id = choice_2a.id
choice_1a.option_b_id = choice_2b.id
choice_1b.option_a_id = choice_2c.id
choice_1b.option_b_id = choice_2d.id
 
choice_2a.option_a_id = choice_3.id
choice_2a.option_b_id = choice_3.id
choice_2b.option_a_id = choice_3.id
choice_2b.option_b_id = choice_3.id
choice_2c.option_a_id = choice_3.id
choice_2c.option_b_id = choice_3.id
choice_2d.option_a_id = choice_3.id
choice_2d.option_b_id = choice_3.id