class Celsius
  def initialize(temp)
    @temp = temp
  end
    
  def to_farenheit
    @temp * 1.8 + 32
  end
  end
  
  calculate = Celsius.new(100)
  puts calculate.to_farenheit