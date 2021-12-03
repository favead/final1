class Comment < ApplicationRecord

	include PgSearch::Model
	
	belongs_to :user
	belongs_to :post
	has_rich_text :rich_content

	multisearchable against: :content

	PgSearch.multisearch_options = {
		using: {
			tsearch: {prefix: true}		
		}
	}

	after_save :reindex

	private

	def reindex
		PgSearch::Multisearch.rebuild(Comment)
	end


end
