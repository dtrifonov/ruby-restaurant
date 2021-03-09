require './app'

RSpec.describe App do
  subject { described_class.new }
  
  context "#handle, config class is invalid" do
    it "should return nil" do
      expect(subject).to receive(:valid_config?).and_return false
      expect(subject.handle).to eql nil
    end
  end

  context "config class is valid" do
    let(:canceling_input) { nil }
    
    context "#handle_login_prompt" do
      context "user was not found" do
        let(:users_controller) { double(UsersController, :handle_prompt => nil) }
        it "should call login controller and exit if the user was not found" do
          expect(UsersController).to receive(:new).and_return(users_controller)
          expect(subject).to receive(:exit_app)
          expect(subject.prompt_label).to eql ''
          subject.handle_login_prompt
        end
      end
      context "user was found" do
        let(:users_controller) { double(UsersController, :handle_prompt => waiter) }
        let(:waiter) {{"1" => {"name" => "Waiter 1", "pin" => "DE28354462304788"}}}
        it "should call login controller, set the user and the prompt label" do
          expect(UsersController).to receive(:new).and_return(users_controller)
          subject.handle_login_prompt
          expect(subject.prompt_label).to eql 'tables'
          expect(subject.user).to eql waiter
        end
      end
    end
  end
end
