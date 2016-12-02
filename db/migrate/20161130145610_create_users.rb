class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    require 'pp'
    pp ENV
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
