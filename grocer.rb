require "pry"
# def items
# 	[
# 		{"AVOCADO" => {:price => 3.00, :clearance => true}},
# 		{"KALE" => {:price => 3.00, :clearance => false}},
# 		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
# 		{"ALMONDS" => {:price => 9.00, :clearance => false}},
# 		{"TEMPEH" => {:price => 3.00, :clearance => true}},
# 		{"CHEESE" => {:price => 6.50, :clearance => false}},
# 		{"BEER" => {:price => 13.00, :clearance => false}},
# 		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
# 		{"BEETS" => {:price => 2.50, :clearance => false}}
# 	]
# end

def consolidate_cart(cart)
  updated_cart = {}
  cart.each do |item|
    item.each do |food, data|
      if updated_cart.key?(food)
      updated_cart[food][:count] += 1
    else
      updated_cart[food] = data
      updated_cart[food][:count] = 1
    end
  end
end
  updated_cart
end

def apply_coupons(cart, coupons)
  discounted_cart = {}
    cart.each do |food, data|
      coupons.each do |cheap_food|
        if food == cheap_food[:item] && data[:count] >= cheap_food[:num]
          data[:count] = data[:count] - cheap_food[:num]
          binding.pry
          if discounted_cart.key?("#{food} W/ COUPON")
            discounted_cart["#{food} W/COUPON"][:count] += 1
          else
            discounted_cart["#{food} W/COUPON"] = {price: coupons[:cost], clearance: cart[:clearance]}
        end
      end
      end
    end
    discounted_cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
