class CreatePages < ActiveRecord::Migration
  def up
    	create_table :pages do |t|
			  t.text :content
  			t.text :preview_a
  			t.text :preview_b
  			t.integer :option_a_id
  			t.integer :option_b_id
  			t.boolean :starting_point, default: false
  			t.boolean :winner, default: nil 
  			t.boolean :conclusion, default: false
  		end
  end

  def down
    drop table :pages
  end
end
