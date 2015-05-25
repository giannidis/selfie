class CreateSelfies < ActiveRecord::Migration
  def change
    create_table :selfies do |t|
      t.string :message
      t.string :email_custom

      t.timestamps null: false
    end
  end
end
