require 'rails_helper'
RSpec.describe BasicHealthUnit::Score, type: :model do
  it 'deve ser valido com atributos' do
    expect(BasicHealthUnit::Score.first).to be_valid
  end

  it 'não deve ser valido com atributos' do
    expect(BasicHealthUnit::Score.new).not_to be_valid
  end
end
