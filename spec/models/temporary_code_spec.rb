require 'rails_helper'

describe TemporaryCode, type: :model do
  it { should validate_presence_of(:user_id) }
end

 
