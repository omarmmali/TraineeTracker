class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def index
    @tracked_trainees = Trainee.all.where(tracking_status: 1)
    @submissions = Submission.all
  end
end
