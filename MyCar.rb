class MyCar

  def initialize(y, c, m)
    @current_speed = 0
    @year = y
    @color = c
    @model = m
  end
  
  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end
    
  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate to #{number} mph."
  end
  
  def current_speed
      puts "You are now going #{@current_speed} mph."
  end
    
  def shut_down(number)
    @current_speed = 0
    puts "You switch of the ignition with the key and the car is now on the ground."
  end
end

    lumina = MyCar.new(1997, 'chevy lumina', 'white')
    lumina.speed_up(20)
    lumina.current_speed
    lumina.speed_up(20)
    lumina.current_speed
    lumina.brake(20)
    lumina.current_speed
    lumina.brake(20)
    lumina.current_speed
    lumina.shut_down
    lumina.current_speed