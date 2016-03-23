class Contact
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name,              type: String
	field :phone_number,      type: Array

	belongs_to :user
end