require 'pry'

def consolidate_cart(cart)
  return_hash = {}
  cart.each do |food|
    food_name = food.keys[0]
    return_hash[food_name] = food.values[0]
    if return_hash[food_name][:count]
      return_hash[food_name][:count] += 1
    else
      return_hash[food_name][:count] = 1
    end
  end
  return_hash
end

def apply_coupons(cart, coupons)
  return_hash = cart.clone
  cart.each do |food, info|
    coupons.each do |coupon|
      if coupon[:item] == food && info[:count] >= coupon[:num]
        coupon_name = coupon[:item] + " W/COUPON"
        coupon_num = info[:count]/coupon[:num]
        return_hash[food][:count] = info[:count]%coupon[:num]
        return_hash[coupon_name] = {
          :price => coupon[:cost],
          :clearance => info[:clearance],
          :count => coupon_num
        }
      end
    end
  end
  return_hash
end

def apply_clearance(cart)
  cart.each do |food, info|
    if info[:clearance]
      info[:price] = (0.8*info[:price]).round(1)
    end
  end
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated,coupons)
  applied_clearance = apply_clearance(applied_coupons)

  total_cost = 0
  applied_clearance.each do |food, info_hash|
    total_cost += (info_hash[:count]*info_hash[:price])
  end

  if total_cost > 100
    total_cost *= 0.90
  end
  total_cost.round(2)
end
