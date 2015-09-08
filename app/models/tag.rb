class Tag < ActiveRecord::Base
	has_many :books_tags, dependent: :destroy
	has_many :books, through: :books_tags
	has_many :users, through: :books_tags
end
