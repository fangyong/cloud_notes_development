class Bill
	include Mongoid::Document
	include Mongoid::MongoidAutoIncrement

	auto_increment :number, :seed => 1000000000  #流水编号
	field :money,            type:String         #用户姓名
	field :time,             type:DateTime       #时间

	belongs_to :user
end