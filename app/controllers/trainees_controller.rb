class TraineesController < ApplicationController
  def show
    @trainee = Trainee.find(params[:id])
  end

  def index
    @trainees = Trainee.all
  end

  def edit 
    @trainee = Trainee.find(params[:id])
  end

  def update
    @trainee = Trainee.find(params[:id])

    if @trainee.update(trainee_params)
      flash[:error] = 'Something Went Wrong'
      redirect_to 'edit'
    else
      flash[:success] = 'Updated Successfully'
      direct_to 'application#index'
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
      :name,
      :uva_handle,
      :live_archive_handle,
      :codeforces_handle
    )
  end
end
