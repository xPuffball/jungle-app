require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "user is added when all fields are present" do
      @user = User.new(
        first_name: "Jesse",
        last_name: "LaPointe",
        email: "test@email.com",
        password: "password1",
        password_confirmation: "password1"
      )
      @user.save
      expect(@user).to be_valid
    end

    it "should fail when name is not valid" do
      @user = User.new(
        first_name: nil,
        last_name: nil,
        email: "test@email.com",
        password: "password1",
        password_confirmation: "password1"
      )
      @user.save
      expect(@user).not_to be_valid
    end

    it "should fail when email is not valid" do
      @user = User.new(
        first_name: "Jesse",
        last_name: "LaPointe",
        email: nil,
        password: "password1",
        password_confirmation: "password1"
      )
      @user.save
      expect(@user).not_to be_valid
    end

    it "should fail if password is not valid" do
      @user = User.new(
        first_name: "Jesse",
        last_name: "LaPointe",
        email: "test@email.com",
        password: nil,
        password_confirmation: "password1"
      )
      @user.save
      expect(@user).not_to be_valid
    end

    it "should fail if password and password confirmation do not match" do
      @user = User.new(
        first_name: "Jesse",
        last_name: "LaPointe",
        email: "test@email.com",
        password: "password1",
        password_confirmation: "password2"
      )
      @user.save
      expect(@user).not_to be_valid
    end

    it "should fail if password confirmation is not valid" do
      @user = User.new(
        first_name: "Jesse",
        last_name: "LaPointe",
        email: "test@email.com",
        password: "password1",
        password_confirmation: nil
      )
      @user.save
      expect(@user).not_to be_valid
    end

    it "should fail if email is already present in database" do
      @user = User.new(
        first_name: "Jesse",
        last_name: "LaPointe",
        email: "test@email.com",
        password: "password1",
        password_confirmation: "password1"
      )
      @user.save
      @user2 = User.new(
        first_name: "Benny",
        last_name: "Harvey",
        email: "TEST@EMAIL.COM",
        password: "password1",
        password_confirmation: "password1"
      )
      @user2.save
      expect(@user2).not_to be_valid
    end

    it "should fail if password and password confirmation are less than 8 characters" do
      @user = User.new(
        first_name: "Jesse",
        last_name: "LaPointe",
        email: "test@email.com",
        password: "short",
        password_confirmation: "short"
      )
      @user.save
      expect(@user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "should pass with valid email and password" do
      @user = User.new(
        first_name: "Jesse",
        last_name: "LaPointe",
        email: "test@email.com",
        password: "password1",
        password_confirmation: "password1"
      )
      @user.save
      userLogin = User.authenticate_with_credentials(@user.email, @user.password)
      expect(userLogin.email).to eq (@user.email)
    end

    it "should authenticate with whitespace present" do
      @user = User.new(
        first_name: "Jesse",
        last_name: "LaPointe",
        email: "test@email.com",
        password: "password1",
        password_confirmation: "password1"
      )
      @user.save
      userLogin = User.authenticate_with_credentials("   test@email.com   ", @user.password)
      expect(userLogin.email).to eq (@user.email)
    end

    it "should authenticate despite the typecase" do
      @user = User.new(
        first_name: "Jesse",
        last_name: "LaPointe",
        email: "test@email.com",
        password: "password1",
        password_confirmation: "password1"
      )
      @user.save
      userLogin = User.authenticate_with_credentials("TEST@EMAIL.com", @user.password)
      expect(userLogin.email).to eq (@user.email)
    end
  end
end

