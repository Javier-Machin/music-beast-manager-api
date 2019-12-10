class Track < ApplicationRecord
  belongs_to :user, foreign_key: :created_by

  # validations
  validates_presence_of :title, :created_by, :artist
end
