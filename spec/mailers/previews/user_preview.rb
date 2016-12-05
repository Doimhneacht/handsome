# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user/registration_confirmation
  def registration_confirmation
    UserMailer.registration_confirmation
  end

end
