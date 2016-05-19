class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :author_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :body, presence: true
end
