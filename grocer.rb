def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item|
    item.each do |name, value|
      if new_hash.key?(name) == false
        new_hash[name] = value
        new_hash[name][:count] = 1
      else
        new_hash[name][:count] += 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  new_cart = {}
  cart.each do |key, value|
    coupons.each do |coupon|
      if key == coupon[:item] && coupon[:num] <= value[:count]
        cart[key][:count] -= coupon[:num]
        if new_cart["#{key} W/COUPON"]
          new_cart["#{key} W/COUPON"][:count] += 1
        else
          new_cart["#{key} W/COUPON"] = {
            price: coupon[:cost],
            clearance: value[:clearance],
            count: 1,
          }
        end
      end
    end
    new_cart[key] = value
  end
  new_cart
end

def apply_clearance(cart)
  cart.each do |item_name, item_hash|
    if item_hash[:clearance] == true
      clearance_price = item_hash[:price] - (item_hash[:price] * 0.2)
      item_hash[:price] = clearance_price
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
    clearance_cart.each do |key, value|
      sub_total = value[:price] * value[:count]
      total += sub_total
    end
    if total > 100
      discount = total * 0.1
      total = total - discount
    end
  total.round(2)
end
