require './motor'
require './color_sensor'

class LegoArray
  attr_reader :motor, :color_sensor, :array

  def move_from_black_to_white(toForward = true)
    while current_color == 'Black'
      if toForward
        motor.move_forward
      else
        motor.move_backward
      end
      current_color = color_sensor.current_color
    end
  end

  def move_from_white_to_black(toForward = true)
    while current_color == 'White'
      if toForward
        motor.move_forward
      else
        motor.move_backward
      end
      current_color = color_sensor.current_color
    end
  end

  def initialize(array)
    @motor = Motor.new
    @color_sensor = ColorSensor.new
    @array = array
  end

  def next
    move_from_black_to_white(true)

    move_from_white_to_black(true)
  end

  def previous
    move_from_black_to_white(false)

    move_from_white_to_black(false)
  end

end
