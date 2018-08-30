module ApplicationHelper
	def in_admin_panel?
		request.fullpath.include?('admin')
	end
end
