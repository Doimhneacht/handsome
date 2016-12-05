require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    subject { get :new }

    it 'returns http success' do
      expect(subject).to have_http_status(:success)
    end

    it 'renders registration form' do
      expect(subject).to render_template(:new)
    end

    it 'assigns a new User to @user' do
      subject
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do

      subject do
        post :create,
        {params: {user: {email: 'user@example.com', password: 'pwd', password_confirmation: 'pwd'} } }
      end

      it 'creates a user in the database' do
        expect { subject }
            .to change(User, :count).by(1)
      end

      it 'sends an email with confirmation link' do
        expect { subject }
            .to change(ActionMailer::Base.deliveries, :count).by(1)
      end

      it 'redirects to the home page' do
        subject
        expect(response).to redirect_to(root_path)
      end

      it 'renders success flash message' do
        subject
        expect(flash[:success]).to match /Please confirm your email address to continue/
      end
    end

    context 'with invalid attributes' do

      subject do
        post :create,
             {params: {user: {email: '', password: 'pwd', password_confirmation: 'pwd'} } }
      end

      it 'does not save the new user in the database' do
        expect { subject }
            .not_to change(User, :count)
      end

      it 'does not send an email with confirmation link' do
        expect { subject }
            .not_to change(ActionMailer::Base.deliveries, :count)
      end

      it 're-renders the :new template' do
        subject
        expect(response).to render_template :new
      end

      it 'renders errors' do
        subject
        expect(flash[:error]).to match /\AEmail can't be blank\nEmail is invalid\z/m
      end
    end
  end

end
