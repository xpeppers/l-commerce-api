namespace :order  do
  desc "create an order"
  task :create, [:user_id, :offer_id, :coupon_code] => :environment do |t, args|
    offer_id = args.offer_id.to_i
    offer = Offer.find(offer_id)

    user_id = args.user_id.to_i
    user = User.find(user_id)

    order = Order.create(user_id: user.id)
    BoughtOffer.create(offer_id: offer.id, order_id: order.id, status: 'unused')

    coupon = Coupon.create(order_id: order.id)
    coupon.update(code: args.coupon_code)

    Payment.create(order_id: order.id, status: 'captured')
    puts "Done"
  end
end
