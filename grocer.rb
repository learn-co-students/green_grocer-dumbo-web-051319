require 'pry'

def consolidate_cart(cart)
  # code here
  newHash = [] 
  quantity = 0
  
  #counts the number of items
  cart.each_with_index do |item, index|
    if newHash.include?(item) == false 
      newHash.push(item)
    else
      #add to count 
      newHash[index]
      
    end
    binding.pry
  end
  binding.pry
  
  #cart.each do |product, product_hash|
  #  if newHash.has_key?(product) == false
      
      #newHash = product_hash
  ##    quantity += 1
#    end
 ##   binding.pry
  #end
  #assigns that number in a new value in the hash
  #returns the new hash
  
  newHash
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
