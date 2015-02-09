class Test < ActiveRecord::Base
  belongs_to :category
  has_many :scores
  has_many :players, :through => :scores
  has_many :users, :through => :scores

  mount_uploader :file, FileUploader

  extend EnumerateIt
  has_enumeration_for :type_unit, :with => Unit, :create_helpers => true

end
