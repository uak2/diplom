class Subdivision < ActiveRecord::Base
  has_many :subdivision_groups
  has_many :groups, :through => :subdivision_groups
end
