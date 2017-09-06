class TraineesController < ApplicationController 
  def index
    @trainees = Trainee.all
  end
 
  def create
    @trainee = Trainee.new(trainee_params)

    if @trainee.save
      redirect_to @trainee
    else
      redirect_to 'create'
    end
  end

  def new
    @trainee = Trainee.new
  end

  def show
    @trainee = Trainee.find(params[:id])
  end

  def edit
    @trainee = Trainee.find(params[:id])
    @tracked_verdict = @trainee.build_tracked_verdict
  end

  def update
    @trainee = Trainee.find(params[:id])

    if @trainee.update(trainee_params)

      flash[:success] = 'Updated Successfully'
      redirect_to @trainee
    else
      flash[:error] = 'Something Went Wrong'
    end
  end

  def toggle_tracking_status
    @trainee = Trainee.find(params[:trainee_id])

    @trainee.tracking_status = (@trainee.tracked? ? :not_tracked : :tracked)
    @trainee.save 
    
    redirect_to 'application#index'
  end

  private

  def trainee_params
    params.require(:trainee).permit(
      :name, :uva_handle, :live_archive_handle, :codeforces_handle,
      :spoj_handle, :timus_handle, :uri_handle, :codechef_handle,
      tracked_verdict_attributes: [
        :submission_error, :cant_be_judged, :in_queue, :compile_error,
        :restricted_function, :runtime_error,
        :output_limit, :time_limit,
        :memory_limit, :wrong_answer,
        :presentation_error, :accepted
      ]
    )
  end
end
