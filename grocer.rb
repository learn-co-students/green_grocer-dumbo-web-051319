
def consolidate_cart(cart)
  new_cart = {}
   cart.each do |item|
     item.each do |name, value|
       if new_cart.key?(name) == false
         new_cart[name] = value
         new_cart[name][:count] = 1
       else
         new_cart[name][:count] += 1
       end
     end
   end
   new_cart
end

def apply_coupons(cart, coupons)
  # code here
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
  cart.each do |item_name, item_hash|
    if item_hash[:clearance] == true
      clearance_price = item_hash[:price] - (item_hash[:price] * 0.2)
      item_hash[:price] = clearance_price
    end
  end
  cart
  # code here
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
