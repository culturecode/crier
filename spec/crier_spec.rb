require 'spec_helper'

describe 'crier' do
  describe "Instance methods" do
    it "should cry" do
      user = User.new
      notification = user.cry("message", {}, nil)
      expect(notification).to be_a(Crier::Notification)
    end
  end
end
