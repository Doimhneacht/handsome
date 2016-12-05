require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'registration_confirmation' do

    it 'renders the headers' do
      user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')
      mail = UserMailer.registration_confirmation(user)

      expect(mail.subject).to eq 'Registration Confirmation at Handsome craft shop'
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(["from@example.com"])
    end

    it 'renders the body' do
      user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')
      mail = UserMailer.registration_confirmation(user)
      expect(mail.body.encoded).to include(confirm_email_user_url(user.confirm_token))
    end
  end

end
