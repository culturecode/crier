require "spec_helper"

describe Crier::Notification do
  describe "#valid?" do
    let(:subject) { Subject.create!(title: "Subject") }

    it "should be valid without a user" do
      notification = Crier::Notification.create!(subject: subject)
      expect(notification.valid?).to be_truthy
    end

    it "should be valid with a user" do
      crier = User.create!
      notification = Crier::Notification.create!(subject: subject, crier: crier)
      expect(notification.valid?).to be_truthy
    end
  end

  describe "#to_others" do
    let(:other_user) { User.create! }
    it "with crier" do
      crier = User.create!
      notification = Crier::Notification.create!(subject: subject, crier: crier).to_others(other_user)
      expect(notification.audience).to match_array([other_user])
    end

    it "without crier" do
      notification = Crier::Notification.create!(subject: subject).to_others(other_user)
      expect(notification.audience).to match_array([other_user])
    end
  end

  describe "about" do
    let(:subject) { Subject.create!(title: "Subject") }
    it "returns notifications" do
      notification = Crier::Notification.create!(subject: subject)
      expect(Crier::Notification.about(subject)).to match_array([notification])
    end
  end
end
