require 'pry'

def consolidate_cart(cart)
  # code here

  #counts the number of items
  cart.each_with_index do |item, index|
    quantity = cart.count(item)
    key = cart[index].keys
    key = key.join
    #binding.pry
    #adds count and quantity to cart hash 
    cart[index][key] = cart[index][key].merge( {:count => quantity} )
  end
  
  cart = cart.uniq
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
