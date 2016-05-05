class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.datetime :start_term, :null => false
      t.datetime :end_term, :null => false
      t.belongs_to :year, :index => true, :null => false
      t.timestamps null: false
    end
  end
end
