class FormStudy < ActiveRecord::Base
  has_many :specialities, dependent: :destroy
end
