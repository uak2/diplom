class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :person, :index => true, :null => false
      t.attachment :photo
      t.timestamps null: false
    end
  end
end
