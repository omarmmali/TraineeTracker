class SubmissionsController < ApplicationController
  def index
    @trainee = Trainee.find(params[:trainee_id])
    @submissions = Submission.all.where(trainee_id: params[:trainee_id])
    if params[:date].present?
      @submissions = @submissions.where(
        'DATE(created_at) BETWEEN ? AND ?',
        params[:date][:from_date],
        params[:date][:to_date]
      )
    end
  end
end
