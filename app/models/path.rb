class Path < ActiveRecord::Base
  belongs_to :image

  validates_presence_of :title, :description, :image
end
