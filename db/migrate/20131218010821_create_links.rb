class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :hyperlink
      t.integer :post_id

      t.timestamps
    end
  end
end
