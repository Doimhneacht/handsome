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

  it 'refuses to save if such email already exists in db' do
    subject.dup.save
    expect(subject.save).to eq false
  end

  it 'downcases domain part of the email before save' do
    subject.email = 'BUMble@BEE.com'
    subject.save
    expect(subject.email).to eq 'BUMble@bee.com'
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
