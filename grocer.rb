require 'pry'

def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |item|
    item.each do |item_name, cost_criteria|
      consolidated_cart[item_name] = cost_criteria
      consolidated_cart[item_name][:count] = 0
    end
  end
  cart.each do |item|
    item.each do |item_name, cost_criteria|
      consolidated_cart.each do |item_name_2, cost_criteria_2|
        if item_name == item_name_2
          cost_criteria_2[:count] += 1
        end
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  cart.each do |k, v|
    coupons.each do |ele|
      if k == ele[:item] && ele[:num] <= v[:count]
        cart[k][:count] -= ele[:num]
        if new_cart["#{k} W/COUPON"]
          new_cart["#{k} W/COUPON"][:count] += 1
        else
          new_cart["#{k} W/COUPON"] = {
            price: ele[:cost],
            clearance: v[:clearance],
            count: 1,
          }
        end
      end
    end
    new_cart[k] = v
  end
  new_cart
end

def apply_clearance(cart)
  new_cart = {}
  cart.each do |k, v|
      v.each do |k2, v2|
        if new_cart[k]
          new_cart[k] = new_cart[k]
        elsif k2 == :clearance && v2 == true
          new_cart[k] = {
            price: (cart[k][:price] * 0.8).round(2),
            clearance:  cart[k][:clearance],
            count:  cart[k][:count]
          }
          elsif k2 == :clearance && v2 == false
            new_cart[k] = v
        end
      end
  end
  new_cart
end

def checkout(cart, coupons)
  total = 0
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  clearance_cart.each do |item, pricing_info|
    sub_tot = pricing_info[:price] * pricing_info[:count]
    total += sub_tot
  end
  if total > 100
    total = total * 0.9
  end
  total.round(2)
end
