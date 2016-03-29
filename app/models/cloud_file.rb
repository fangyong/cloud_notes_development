class CloudFile
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name,    type: String
	field :path,    type: String

	belongs_to :user
end