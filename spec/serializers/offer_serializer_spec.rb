require 'rails_helper'

describe OfferSerializer, type: :serializer do

  let(:resource) { build(:offer, price: 9.9, id: 1) }

  let(:serializer) { OfferSerializer.new(resource) }
  let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }

  subject do
    JSON.parse(serialization.to_json)
  end

  it 'uses a double precision for price' do
    expect(subject['price']).to eq('9.90')
  end

end
