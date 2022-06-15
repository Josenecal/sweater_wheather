require 'rails_helper'

RSpec.describe User do

  it 'validations' do
    should validate_presence_of :email
    should validate_uniqueness_of :email
    should validate_presence_of :password_digest
  end

  context 'attributes' do
    it "saves a password digest without saving sensitive information" do
      new_user = create(:user)
      saved_user = User.find(new_user.id)
      expect(saved_user.id.class).to eq Integer
      expect(saved_user.password_digest).not_to eq new_user.password
      expect(saved_user.password).to eq nil
      expect(saved_user.password_confirmation).to eq nil
      expect(saved_user.api_key).not_to eq nil
    end

    it "requires new users to provide a unique email" do
      user_1 = create(:user)
      user_2 = build(:user, email: user_1.email)
      expect(user_2.save).to eq false
    end

    it "has all expected keys" do
      user_1 = create(:user)
      expect(user_1.attributes.keys).to eq ["id", "email", "password_digest", "api_key", "created_at", "updated_at"]
    end
  end

end
