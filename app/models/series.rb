class Series < ApplicationRecord
	has_many :amiibos

	validates_presence_of :name
	validates_uniqueness_of :name
end
