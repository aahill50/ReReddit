class Comment < ActiveRecord::Base
  validate :content, :author_id, :post_id, presence: true

  belongs_to(
    :author,
    class_name: "User"
  )

  belongs_to :post

  has_many(:child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )

  belongs_to(:parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )
end