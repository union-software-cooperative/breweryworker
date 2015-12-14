module ApplicationHelper
	def profile_thumb(person)		
		unless person.attachment.blank?
			image_tag person.attachment.thumb.url, class: "profile_thumb"
		else
			"<span class=\"glyphicon glyphicon-user\"></span>".html_safe
		end
	end

	def pencil_button
		"<span class=\"small glyphicon glyphicon-pencil\"/>".html_safe 
	end

	def gender_options(person)
    options_for_select(
      ([
        t('gender.male'), 
        t('gender.female'),
        t('gender.other')
        ]).uniq, 
      person.gender
    )
  end

  def owner_union
  	#Rails.application.config.owner_union ||= Union.find_by_short_name(ENV['OWNER_UNION']) rescue nil # Added for tests, since I couldn't get seeds to work
		#Rails.application.config.owner_union
		Union.find_by_short_name(ENV['OWNER_UNION']) rescue nil
	end

	def owner?
		return false unless current_person.present?
		return false unless owner_union.present?
		current_person.union.id == owner_union.id 
	end

	def can_edit_union?(union)
		if current_person.present?
			if union.blank? || owner? || current_person.union.id == union.id
				true
			else
				false
			end 
		else
			false
		end
	end

	def selected_option(entity)
		entity ? 
        options_for_select([[entity.name, entity.id]], entity.id) :
        []
	end
end
