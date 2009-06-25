class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = @current_user
    if @current_user
      if @invitation.save
#        Mailer.deliver_invitation(@invitation, signup_url(@invitation.token))
        flash[:notice] = "Thank you, invitation sent."
        redirect_to new_entry_path
      else
        render :action => 'new'
      end
    else # There is no curr_user - New user is letting us know they'd like to join
      @invitation.save
      flash[:notice] = "Thank you, we will notify when we are ready."
      redirect_to root_url
    end
  end
end
