class Stage < ActiveRecord::Base
  belongs_to :image
  belongs_to :merchant
  belongs_to :path

  validates_presence_of :title, :description, :image, :merchant, :path

end
