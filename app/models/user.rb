class User
	include Mongoid::Document
	include Mongoid::MongoidAutoIncrement

	auto_increment :number, :seed => 1000000000  #用户编号
	field :name,            type:String          #用户姓名
	field :mobile,          type:Integer         #用户手机号

	has_many :bills, dependent: :restrict 

	def income_bills
		bills.where(_type: "IncomeBill")
	end

	def spend_bills
		bills.where(_type: "SpendBill")
	end
end