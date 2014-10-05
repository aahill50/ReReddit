class Vote < ActiveRecord::Base
	validates :value, :votable_id, presence: true

	belongs_to(
		:votable,
		polymorphic: true
	)

end