class People::InvitationsController < Devise::InvitationsController
  
  def update
    response = super
    if resource.errors.empty?
      resource.follow!(resource.union)
      
      # Follow all agreements too
      #resource.union.recs.each do |r|
      #  resource.follow!(r)
      #end
    end
    return response
  end

  private

  def after_invite_path_for(resource)
    edit_profile_path @invitee
  end

  def after_accept_path_for(current_person)
    edit_profile_path current_person
  end

  def invite_resource
    @invitee = resource_class.invite!(invite_params, current_inviter) do |u|
      # u.errors.add(:union, "cannot be changed.") unless can_edit_union?(u.union) # Remarked because authorization is now done in person model's validation 
    end
  end

  def invite_params
    result = params.permit(person: [:authorizer, :gender, :email,:invitation_token, :union_id, :first_name, :last_name,  :title, :address, :mobile, :fax, :country, :languages => []])[:person].merge(authorizer: current_person)
    result[:languages].delete("") if result[:languages]
    result
   end

  def update_resource_params
    result = devise_parameter_sanitizer.sanitize(:accept_invitation)
    invitee = resource_class.find_by_invitation_token(result[:invitation_token], false)
    authorizer = invitee.invited_by unless invitee.blank?
    result.merge(authorizer: authorizer)
  end
  
  def breadcrumbs
    [
      [I18n.t("layouts.navbar.people").titlecase, people_path, controller?("people") && action?("index")],
      [I18n.t("devise.invitations.new.header"), new_person_invitation_path, action?("new")]
    ]
  end
end
