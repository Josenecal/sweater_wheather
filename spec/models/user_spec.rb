require 'rails_helper'

RSpec.describe User do

  it 'validations' do
    should validate_presence_of :email
    should validate_uniqueness_of :email
    should validate_presence_of :password_digest
  end

  context 'bcrypt password concealment' do
    it "saves a given password as password digest, which does not match an actual password" do
      new_user = User.create!(email: "pabu@ferritmail.org", password: "abc123", password_confirmation: "abc123", api_key: SecureRandom.hex)
      saved_user = User.find(new_user.id)
      expect(saved_user.id.class).to eq Integer
      expect(saved_user.password_digest).not_to eq "abc123"
      expect(saved_user.password).to eq nil
      expect(saved_user.api_key).not_to eq nil
    end
  end

end
