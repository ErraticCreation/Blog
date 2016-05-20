class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :author_name, presence: true, length: { maximum: 50 }
  validates :body, presence: true
end
