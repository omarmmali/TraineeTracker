require 'rails_helper'

RSpec.describe TraineesController, type: :controller do
  describe 'GET index' do
    it 'has a 200 status code' do
      get :index

      expect(response.status).to eq(200)
    end
  end
  it "toggles a trainee's tracking status" do
    Trainee.create(tracking_status: 0)

    post :toggle_tracking_status, params: { trainee_id: Trainee.last.id }

    expect(Trainee.last.tracking_status).to eq('tracked')
  end
  it "edits trainees' attributes" do
    Trainee.create(name: 'koko', uva_handle: 'koko')

    put :update, params: {
      id: Trainee.last.id,
      trainee: { name: 'koko1', uva_handle: 'koko2' }
    }

    expect(Trainee.last.name).to eq('koko1')
    expect(Trainee.last.uva_handle).to eq('koko2')
  end
end
