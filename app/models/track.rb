class ApplicationRecord < ActiveRecord::Base
  include ActiveStorageSupport::SupportForBase64
end

class Track < ApplicationRecord
  has_one_base64_attached :file
  belongs_to :user, foreign_key: :created_by

  # validations
  validates_presence_of :title, :created_by, :artist
end
