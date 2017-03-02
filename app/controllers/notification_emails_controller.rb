class NotificationEmailsController < ApplicationController
  def new
    @house_name = notification_params[:house_name]
    NotificationMailer.new_notification(@house_name).deliver_later
    redirect_to root_path
  end

  private

  def notification_params
    params.permit(:house_name)
  end
end
