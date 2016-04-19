class Product < ActiveRecord::Base
  validates :name, :presence => true,:length => { :in => 3..20 }
  validates :description, :presence => true,:length => { :in => 3..2000 }
  validates :img, :presence => false,:length => { :in => 3..200 }
  validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

  has_and_belongs_to_many :groups

end
