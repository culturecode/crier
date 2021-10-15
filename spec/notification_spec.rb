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

    it "causes audience to include the given user when the notification has a crier" do
      crier = User.create!
      notification = Crier::Notification.create!(subject: subject, crier: crier).to_others(other_user)
      expect(notification.audience).to match_array([other_user])
    end

    it "causes audience to include the given user when the notification has no crier" do
      notification = Crier::Notification.create!(subject: subject).to_others(other_user)
      expect(notification.audience).to match_array([other_user])
    end
  end

  describe "#about" do
    let(:subject) { Subject.create!(title: "Subject") }

    it "returns notifications with a matching subject" do
      notification = Crier::Notification.create!(subject: subject)
      expect(Crier::Notification.about(subject)).to include(notification)
    end

    it "does not returns notifications without a matching subject" do
      notification = Crier::Notification.create!(subject: Subject.create!(title: "Other subject"))
      expect(Crier::Notification.about(subject)).not_to include(notification)
    end
  end

  describe '#save' do
    subject { Crier::Notification.new }

    it 'makes the notification private if an audience is given' do
      subject.audience = [User.create!]
      subject.save!
      expect(subject).to be_private
    end

    it 'does not make the notification private if no audience is given' do
      subject.audience = []
      subject.save!
      expect(subject).not_to be_private
    end

    it 'makes the notification private if no audience is given but the `private` attribute is set to true' do
      subject.private = true
      subject.audience = []
      subject.save!
      expect(subject).to be_private
    end

    it 'makes the notification private if an audience is given and the `private` attribute is set to false' do
      subject.audience = [User.create!]
      subject.private = false
      subject.save!
      expect(subject).to be_private
    end
  end
end
