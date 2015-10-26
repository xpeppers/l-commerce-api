FactoryGirl.define do
  factory :order

  factory :captured_order, class: Order do
    association :payment, factory: :payment, status: 'captured', strategy: :build
  end
end
