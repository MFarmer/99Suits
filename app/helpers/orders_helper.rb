module OrdersHelper

  def address(order)
    "#{order.street}, #{order.city}, #{order.state}, #{order.zip}"
  end

end
