require 'rails_helper'
RSpec.describe BasicHealthUnit, type: :model do
  subject {
    described_class.new(
      name: 'UBS Lorem Ipsum',
      city: 'Lorem ipsum',
      cnes: '99'
    )
  }

  it 'deve ser valido com atributos' do
    expect(BasicHealthUnit::Score.first).to be_valid
  end

  it 'should not be valid without name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid without city' do
    subject.city = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid without cnes' do
    subject.cnes = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid with no attributes' do
    subject.name = subject.city = subject.cnes = nil
    expect(subject).to_not be_valid
  end

  it 'last saved basic_health_unit has to be equal or more than 37691' do
    scores = BasicHealthUnit::Score.new(
      size:                   1,
      adaptation_for_seniors: 2,
      medical_equipment:      3,
      medicine:               2
    )
    scores.save
    subject.scores_id = scores.id

    geocode = BasicHealthUnit::Geocode.new(
      lat:  -42.0000,
      long: -42.0000
    )
    geocode.save
    subject.geocode_id = geocode.id

    subject.save
    expect(subject.id).to be >= 37_691
  end
end
