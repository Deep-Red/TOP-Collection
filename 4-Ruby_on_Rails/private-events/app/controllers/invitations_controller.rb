class InvitationsController < ApplicationController
  def new
  end

  def create
    @invitation = invitation_params[:event].invitation.build(:user_id, current_user)
  end

  private
  def invitation_params
    params.require(:invitation).permit(:event)
  end
end
