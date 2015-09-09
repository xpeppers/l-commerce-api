FactoryGirl.define do
  factory :order do

  end

  factory :captured_order, class: Order do
    association :payment, factory: :payment, status: 'captured', strategy: :build
  end
end
