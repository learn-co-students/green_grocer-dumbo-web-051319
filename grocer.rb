def consolidate_cart(cart)

	entry_counts = cart.group_by{ |entry| entry}.map{ |item, details| [item, details.count] }
	entry_counts.each { |elem| 

		elem[0].each_key { |k|
			cart.each { |entry|
				entry.each{ |item, details|
					if item == k 
						details[:count] = elem[1]
					end
				}
			}
		}
	}

	intermediate = cart.uniq
	return_obj = {}

	intermediate.each { |elem|
		elem.each { |k,v|
			return_obj[k] = v
		}
	}

	return return_obj

end

############################################################

def apply_coupons(cart, coupons)

	num_extra_coupons = 0

	if coupons.uniq.length == coupons.length
		puts "coupons does not contain duplicates"
	else
		print coupons
		puts "";print"\n"
		print coupons.uniq
		puts "";print"\n"
		duplicates = coupons.group_by { |e| e }.keep_if { |_, e| e.length > 1 }.map { |k, v| { k => v.length } } 
		print duplicates
		duplicates[0].each { |k,v| num_extra_coupons = v-1 }
		puts "";print"\n"
	end

	puts num_extra_coupons

	coupons.each { |coupon|
		sale_item = coupon[:item]
		num_sale_items = coupon[:num]    

		if cart.has_key?(sale_item)
			num_items = cart[sale_item][:count] 
			cart[sale_item][:count] -= num_sale_items 

			cart["#{sale_item} W/COUPON"] = { }.merge!( price: coupon[:cost], clearance: cart[coupon[:item]][:clearance], count: ( num_items / coupon[:num] ) + num_extra_coupons )
		end
	}

	return cart
end

###########################################################

def apply_clearance(cart)
  cart.each { |item, info|
		if (info[:clearance] == true)
			info[:price] = (info[:price] * 0.8).round(4).truncate(4)
		end
	}
	return cart
end

##########################################################

def checkout(cart, coupons)

  # Apply Coupons Method
  if coupons.length > 0
    num_extra_coupons = 0

    if coupons.uniq.length == coupons.length
      puts "coupons does not contain duplicates"
    else
      duplicates = coupons.group_by { |e| e }.keep_if { |_, e| e.length > 1 }.map { |k, v| { k => v.length } }
      duplicates[0].each { |k, v| num_extra_coupons = v - 1 }
    end

    coupons.each { |coupon|
      sale_item = coupon[:item]
      num_sale_items = coupon[:num]

      if cart.has_key?(sale_item)
        num_items = cart[sale_item][:count]
        cart[sale_item][:count] -= num_sale_items

        cart["#{sale_item} W/COUPON"] = {}.merge!(price: coupon[:cost], clearance: cart[coupon[:item]][:clearance], count: (num_items / coupon[:num]) + num_extra_coupons)
      end
    }
  end

  # Apply Clearance Method
  cart.each { |item, info|
    if (info[:clearance] == true)
      info[:price] = (info[:price] * 0.8).round(4).truncate(3)
    end
  }

  # Calculate Total
  sum = 0
  cart.each { |item, info|
    sum += info[:price] * info[:count]
  }

  if sum > 100
    cart.each { |item, info|
      info[:price] = (info[:price] * 0.9).round(4).truncate(3)
    }
  end

  puts sum

  # Consolidate Cart
  cart = [cart]

  entry_counts = cart.group_by { |entry| entry }.map { |item, details| [item, details.count] }
  entry_counts.each { |elem|
    elem[0].each_key { |k|
      cart.each { |entry|
        entry.each { |item, details|
          if item == k
            details[:count] = elem[1]
          end
        }
      }
    }
  }

  intermediate = cart.uniq
  return_obj = {}

  intermediate.each { |elem|
    elem.each { |k, v|
      return_obj[k] = v
    }
  }

  cart = return_obj

  # return cart
  return sum
end
