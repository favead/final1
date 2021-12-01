class Post < ApplicationRecord

	include PgSearch::Model

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :rates, dependent: :destroy

	has_rich_text :rich_content

	multisearchable against:[:name,:content,:tags],
					using: {
						tsearch: {prefix: true}
					}

	after_save :reindex

	private	

	def reindex
		PgSearch::Multisearch.rebuild(Post)
	end

end
