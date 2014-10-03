class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  belongs_to(
    :author,
    class_name: "User"
  )

  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub
end