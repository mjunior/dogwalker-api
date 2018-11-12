class PriceCalculator
  def initialize dog_walking
    @count = dog_walking.pets
    @product = Product.find_by_duration(dog_walking.duration)
  end
  
  def calculate
    ((@count - 1) * @product.aditional_price) + @product.first_price
  end
end