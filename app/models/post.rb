class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  belongs_to(
    :author,
    class_name: "User"
  )

  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments, inverse_of: :post
  has_many :votes, as: :votable

  has_many(:top_level_comments,
    -> { where("parent_comment_id IS NULL") },
    class_name: 'Comment',
    foreign_key: :post_id
  )

  def comments_by_parent_id
    comment_tree = Hash.new { |h, key| h[key] = [] }

    comments.each do |comment|
      comment_tree[comment.parent_comment_id] << comment
    end

    comment_tree
  end

  def karma
    positive_karma = self.votes.where(value: 1).count
    negative_karma = self.votes.where(value: -1).count

    positive_karma - negative_karma
  end
end