class Group < ActiveRecord::Base
  validates :name, :presence => true,:length => { :in => 3..20 }

  has_and_belongs_to_many :products
end
