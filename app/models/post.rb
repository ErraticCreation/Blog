class Post < ActiveRecord::Base
  has_many :comments
  mount_uploader :picture, PictureUploader
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true
  validate :picture_size

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
