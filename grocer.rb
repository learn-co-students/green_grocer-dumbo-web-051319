require 'pry'

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |h|
    h.each do |k, v|
      if !new_cart.key?(k)
        new_cart[k] = v.clone
        new_cart[k][:count] = 1
      else
        new_cart[k][:count] += 1
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  if coupons.empty?
    return cart
  end
  coupons.each do |coupon|
    item_with_coupon = "#{coupon[:item]} W/COUPON"
    if cart.key?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
      cart[coupon[:item]][:count] -= coupon[:num]
      if cart.key?(item_with_coupon)
        cart[item_with_coupon][:count] += 1
      else
        cart[item_with_coupon] = cart[coupon[:item]].clone
        cart[item_with_coupon][:price] = coupon[:cost]
        cart[item_with_coupon][:count] = 1
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, data|
    if data[:clearance] == true
      data[:price] -= data[:price] * 0.2
    end
  end
end

def checkout(cart, coupons)
  total = 0
  new_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  new_cart.each do |k, v|
    total += v[:price] * v[:count]
  end
  if total > 100
    total -= total * 0.1
  end
  total
end

#consolidate_cart([{"AVOCADO"=>{:price=>3.0, :clearance=>true}}, {"AVOCADO"=>{:price=>3.0, :clearance=>true}}, {"KALE"=>{:price=>3.0, :clearance=>false}}])

#apply_coupons({"CHEESE"=>{:price=>6.5, :clearance=>false, :count=>4}, "AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>3}}, [{:item=>"AVOCADO", :num=>2, :cost=>5.0}, {:item=>"CHEESE", :num=>3, :cost=>15.0}])

#checkout([{"BEETS"=>{:price=>2.5, :clearance=>false}}, {"BEER"=>{:price=>13.0, :clearance=>false}}, {"BEER"=>{:price=>13.0, :clearance=>false}}, {"BEER"=>{:price=>13.0, :clearance=>false}}], [{:item=>"BEER", :num=>2, :cost=>20.0}])