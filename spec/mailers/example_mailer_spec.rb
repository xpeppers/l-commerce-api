require "rails_helper"

describe ExampleMailer, type: :mailer do
  describe 'welcome_email' do
    let(:user) { create(:user, email: "emailhere") }
    let(:temp_code) { TemporaryCode.create({user_id: user.id}) }
    let(:mail) { described_class.welcome_email(user, temp_code).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('TDVpass recupera password')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['from@example.com'])
    end

  end
end
