require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
    
    let(:user) { instance_double("User", :email => "example_1@cvstom.org", :activation_token => User.token) }
    let(:mail) { UserMailer.account_activation(user) }

	it 'renders the subject' do
      expect(mail.subject).to eq('Activate Your Account')
    end
 
    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end
 
    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@cvstom.org'])
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded).to include("account_activations/#{user.activation_token}")
    end
end
