module Admin::UserHelper

	def getUserType(attrName, attrValue)
		
		if attrName == 'user_type' && attrValue == 0
			"Admin User"
		elsif attrName == 'user_type' && attrValue == 1
			"Normal User"
		else
			attrValue	
		end

	end

end