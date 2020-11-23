require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:non_activate) }

  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@example.com"])
      # expect(mail.subject).to eq("アカウント有効化／ダテさん")
    end

    it "renders the body" do
      expect(mail.body.encoded).to match user.name
      expect(mail.body.encoded).to match user.activation_token
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
  end

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      user.reset_token = User.new_token
      # expect(mail.subject).to eq("パスワードリセット／ダテさん")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@example.com"])
    end

    it "renders the body" do
      user.reset_token = User.new_token
      expect(mail.body.encoded).to match user.reset_token
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
  end

end
