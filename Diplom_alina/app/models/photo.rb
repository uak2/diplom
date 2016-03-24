class Photo < ActiveRecord::Base
  belongs_to :person
  has_attached_file :photo, styles: { medium: "365x300>", thumb: "180x90>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  public

  def change_display(photo)
    result = ['Фотография']
    result << ['Изменена',self.photo_file_name, photo.photo_file_name] if  self.photo_file_name != photo.photo_file_name
    result << photo.created_at
    return result
  end

end
