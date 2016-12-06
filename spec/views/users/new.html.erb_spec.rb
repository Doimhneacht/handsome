require 'rails_helper'

RSpec.describe 'users/new.html.erb', type: :view do
  it 'renders registration form' do
    @user = User.new
    render
    header = /<h1>User registration<\/h1>/
    form = /name="user\[email\]".+name="user\[password\]".+name="user\[password_confirmation\]".+name="commit"/m
    expect(rendered).to match header
    expect(rendered).to match form
  end
end
