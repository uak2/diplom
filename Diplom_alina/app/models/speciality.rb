class Speciality < ActiveRecord::Base
  has_many :plans
  belongs_to :form_study
end
