module ApplicationHelper
	def app_title
		'I Need'
	end

	def title_helper
		"#{app_title}: #{controller_name} #{action_name}"
	end
end
