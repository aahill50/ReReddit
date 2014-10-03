class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  belongs_to(
    :author,
    class_name: "User"
  )

  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments, inverse_of: :post

  has_many(:top_level_comments,
    -> { where("parent_comment_id IS NULL") },
    class_name: 'Comment',
    foreign_key: :post_id
  )

end