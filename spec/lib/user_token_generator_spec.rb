require 'rails_helper'

describe UserTokenGenerator, type: :lib do

  it 'generates a random string of 32 hexadecimal characters' do
    expect(UserTokenGenerator::generate).to match(/^[a-f0-9]{32}$/)
  end

end
