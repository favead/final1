class Post < ApplicationRecord

	include PgSearch::Model

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :rates, dependent: :destroy
	has_many :post_tags, dependent: :destroy
	has_many :tags, through: :post_tags
	has_rich_text :rich_content

	multisearchable against:[:name,:content,:tags]

	PgSearch.multisearch_options = {
		using: {
			tsearch: {prefix: true}		
		}
	}

	after_save :reindex

	def tagging
		self.tags.map(&:title).join(' ')
	end

	def tagging=(titles)
		self.tags = titles.split(' ').map do |title|
			Tag.where(title: title.strip).first_or_create
		end
	end


	private	

	def reindex
		PgSearch::Multisearch.rebuild(Post)
	end

end
	