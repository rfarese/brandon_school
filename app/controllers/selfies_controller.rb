class SelfiesController < ApplicationController
  before_action :authorize_user 

  def new
    @selfie = Selfie.new
  end

  def create
    selfie = Selfie.new(image: params[:image].tempfile)
    if selfie.save
      render json: { errors: "No errors", selfie_id: selfie.id }
    end
  end
end
