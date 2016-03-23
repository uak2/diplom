class Photo < ActiveRecord::Base
  belongs_to :person
  has_attached_file :photo, styles: { medium: "365x300>", thumb: "180x90>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
