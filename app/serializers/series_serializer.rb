class SeriesSerializer < ActiveModel::Serializer
	attributes :id, :name
	has_many :amiibos
end
