require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it 'should validate with valid parameters' do
      @user = User.new(password: 'some_password', password_confirmation: 'some_password', email: 'some_email', first_name: 'bob', last_name: 'dole')
      expect(@user).to be_valid
    end

    it 'should not be valid if there is no first_name' do
      @user = User.new(password: 'some_password', password_confirmation: 'some_password', email: 'some_email', last_name: 'dole')
      expect(@user).to be_invalid
    end

    it 'should not be valid if there is no last_name' do
      @user = User.new(password: 'some_password', password_confirmation: 'some_password', email: 'some_email', first_name: 'bob')
      expect(@user).to be_invalid
    end

    it 'should not be valid if there is no email' do
      @user = User.new(password: 'some_password', password_confirmation: 'some_password', first_name: 'bob', last_name: 'dole')
      expect(@user).to be_invalid
    end

    it 'should not be valid if there is no password' do
      @user = User.new(password_confirmation: 'some_password', email: 'some_email', first_name: 'bob', last_name: 'dole')
      expect(@user).to be_invalid
    end

    it 'should not be valid if there is no password confirmation' do
      @user = User.new(password: 'some_password', email: 'some_email', first_name: 'bob', last_name: 'dole')
      expect(@user).to be_invalid
    end

    it 'should not be valid if the passwords do not match' do
      @user = User.new(password: 'some_password', password_confirmation: 'some_password2', email: 'some_email', first_name: 'bob', last_name: 'dole')
      expect(@user).to be_invalid
    end

    it 'should not be valid if there is a duplicate email' do
      @user = User.new(password: 'some_password', password_confirmation: 'some_password', email: 'some_email', first_name: 'bob', last_name: 'dole')
      @user.save!
      @user2 = User.new(password: 'some_password', password_confirmation: 'some_password', email: 'some_email', first_name: 'bob', last_name: 'dole')
      expect(@user2).to be_invalid
    end

    it 'should not be valid if there is a duplicate email with different case letters' do
      @user = User.new(password: 'some_password', password_confirmation: 'some_password', email: 'some_email', first_name: 'bob', last_name: 'dole')
      @user.save!
      @user2 = User.new(password: 'some_password', password_confirmation: 'some_password', email: 'some_EMAIL', first_name: 'bob', last_name: 'dole')
      expect(@user2).to be_invalid
    end

    it 'should not be valid if the password is less than 6 characters long' do
      @user = User.new(password: 'some_', password_confirmation: 'some_', email: 'some_email', first_name: 'bob', last_name: 'dole')
      expect(@user).to be_invalid
    end

    describe '.authenticate_with_credentials' do
      it 'should not be valid if the session password does not match the user password' do
        @user = User.create(password: 'some_password', password_confirmation: 'some_password', email: 'some_email', first_name: 'bob', last_name: 'dole')
        authenticate = User.authenticate_with_credentials('some_email', 'some_rd')
        expect(authenticate).to be_nil
      end


      it 'should be valid if the session password does match the user password' do
        @user = User.create(password: 'some_password', password_confirmation: 'some_password', email: 'some_email', first_name: 'bob', last_name: 'dole')
        authenticate = User.authenticate_with_credentials('some_email', 'some_password')
        expect(authenticate).to be_truthy
      end

      it 'should be valid if the session email matches the user email but with trailing and leading spaces' do
        @user = User.create(password: 'some_password', password_confirmation: 'some_password', email: 'some_email', first_name: 'bob', last_name: 'dole')
        authenticate = User.authenticate_with_credentials('     some_email    ', 'some_password')
        expect(authenticate).to be_truthy
      end

      it 'should be valid if the session email matches the user email but with different casing' do
        @user = User.create(password: 'some_password', password_confirmation: 'some_password', email: 'some_email', first_name: 'bob', last_name: 'dole')
        authenticate = User.authenticate_with_credentials('     somE_eMail    ', 'some_password')
        expect(authenticate).to be_truthy
      end
    end

  end




end
