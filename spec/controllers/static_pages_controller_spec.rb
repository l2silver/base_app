require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end

    it "returns logged in view" do
      get :home, nil, {'user_id' => 1}
      expect(response).to render_template("static_pages/logged_in")
    end

   
    it "includes returns logged out view" do
      get :home, nil, nil
      expect(response).to render_template("static_pages/logged_out")
    end
    
  end

end
