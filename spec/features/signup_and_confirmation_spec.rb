require 'rails_helper';

describe 'User registration' do
  let(:user_email) { 'test@test.fr' }
  let(:user_password) { 'azerty' }

  before :each do
    visit new_user_registration_path

    fill_in 'user_email', with: user_email
    fill_in 'user_password', with: user_password
    fill_in 'user_password_confirmation', with: user_password

    click_button 'Sign up'
  end

  it "should save the user" do
    user = User.find_for_authentication(email: user_email)
    expect(user).to be_valid
  end

  it "should create a request" do
    user = User.find_for_authentication(email: user_email)
    expect(user.request).to be_valid
  end

  it "the request shoud have the status unconfirmed" do
    user = User.find_for_authentication(email: user_email)
    expect(user.request.status) == "unconfirmed"
  end

  it "shows notif: confirmation email has been sent" do
    expect(page).to have_css(".alert", :text => "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
  end

  it "user open email and follow the confirmation link" do
    mail = ActionMailer::Base.deliveries[0]
    token = mail.body.decoded.match(/confirmation_token=([^"]+)/)[1]
    assert_equal User.find_by(email: user_email).confirmation_token, token
    expect(mail.subject) == "Confirmation instructions"
    visit "users/confirmation?confirmation_token=#{token}"
    expect(page).to have_css(".alert", :text => "Your email address has been successfully confirmed.")
  end

  it "change status request to confirmed, and position is attributed" do
    user = User.find_for_authentication(email: user_email)
    expect(user.request.status) == "confirmed"
    expect(user.request.position) != nil
  end
end

