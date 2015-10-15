require 'rails_helper'

describe TokenGenerator, type: :lib do

  it 'generates a random string of 32 hexadecimal characters' do
    expect(TokenGenerator::generate).to match(/^[a-f0-9]{32}$/)
  end

end
