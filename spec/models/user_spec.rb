require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  subject do
    User.new(name: 'Hanna', email: 'hanna@example.com', password: 'random', password_confirmation: 'random')
  end

  it 'saves when data is ok' do
    expect(subject.save).to eq true
  end

  it 'refuses to save if email is blank' do
    ['', '   ', nil].each do |value|
      subject.email = value
      expect(subject.save).to eq false
    end
  end

  it 'refuses to save if email is fake' do
    %w(hanna.example.com ginger@bread double@dotted..email i'm@fake.ru).each do |invalid_email|
      subject.email = invalid_email
      expect(subject.save).to eq false
    end
  end

  it 'refuses to save if password differs from password_confirmation' do
    subject.password_confirmation = 'notRandom'
    expect(subject.save).to eq false
  end

  it 'refuses to save if password is nil' do
    subject.password = nil
    expect(subject.save).to eq false
  end
end
