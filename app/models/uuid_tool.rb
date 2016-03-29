module UuidTool
	def get_uuid
		uuid = UUID.new
	    uuid_str = uuid.generate.to_s
	    uuid_sub_str = uuid_str.split("-")
	    flow_no = ""
	    uuid_sub_str.each do |body|
	        flow_no += body
	    end
	    return flow_no
	end

	def get_uuid_8
		SecureRandom.hex 8
	end

end