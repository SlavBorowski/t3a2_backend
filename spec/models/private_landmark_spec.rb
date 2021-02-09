require 'rails_helper'

RSpec.describe PrivateLandmark, type: :model do
  subject { FactoryBot.build(:private_landmark)}

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without city' do
      subject.city = nil
      expect(subject).to_not be_valid
    end
  end
end
