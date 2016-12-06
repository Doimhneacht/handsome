require 'rails_helper'

RSpec.describe 'UserRegister', type: :request do
  describe 'POST /users' do
    it 'renders errors when user provides invalid data' do
      post users_path, params: { user: { email: '', password: '', password_confirmation: '' } }
      expect(response).to render_template 'users/new'
      expect(response.body).to match /class="error"/
    end

    it 'renders no errors when user provides valid data' do
      post users_path, params: { user: { email: 'user@example.com', password: 'pwd', password_confirmation: 'pwd' } }
      expect(response).to redirect_to root_path
      follow_redirect!
      expect(response.body).not_to match /class="error"/
      expect(response.body).to match /class="flash/
    end
  end
end
