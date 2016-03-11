class Comment
	include Mongoid::Document
	include Mongoid::MongoidAutoIncrement

	auto_increment :number, :seed => 1000000000  #流水编号
	field :text,             type:String         #内容

	belongs_to :user

	has_many :replies
end