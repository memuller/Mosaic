module ApplicationHelper

	def hex_rgb(arg)
		arr = []
		arg.each { |k, v| arr << Math.sqrt(v).floor }			
		"#%x%x%x" % arr
	end 
end
