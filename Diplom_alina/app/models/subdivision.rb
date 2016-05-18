class Subdivision < ActiveRecord::Base
  has_many :subdivision_groups
  has_many :groups, :through => :subdivision_groups
  has_one :type_subdivision
end
