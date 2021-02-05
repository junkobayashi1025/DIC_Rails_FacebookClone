class Blog < ApplicationRecord
 has_many :comments, dependent: :destroy
 belongs_to :user
 validates :title, presence: true, length: { maximum: 30 }
 validates :body, presence: true, length: { maximum: 1000 }
 mount_uploader :image, ImageUploader
end
