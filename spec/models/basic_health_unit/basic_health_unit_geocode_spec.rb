require 'rails_helper'
RSpec.describe BasicHealthUnit::Geocode, type: :model do
  it 'deve ser valido com atributos' do
    expect(BasicHealthUnit::Geocode.first).to be_valid
  end

  it 'não deve ser valido com atributos' do
    expect(BasicHealthUnit::Geocode.new).not_to be_valid
  end
end
