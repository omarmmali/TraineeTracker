class SubmissionsController < ApplicationController
  def index
    @sumbissions = Sumbission.all.where(trainee_id: params[:trainee_id])
  end
end
