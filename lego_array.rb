require './motor'
require './color_sensor'

class LegoArray
  attr_reader :motor, :color_sensor, :array

  def moveFromBlackToWhite
    while current_color == 'Black'
      motor.move_forward
      current_color = color_sensor.current_color
    end
  end

  def moveFromWhiteToBlack
    while current_color == 'White'
      motor.move_forward
      current_color = color_sensor.current_color
    end
  end

  def initialize(array)
    @motor = Motor.new
    @color_sensor = ColorSensor.new
    @array = array
  end

  def next
    moveFromBlackToWhite

    moveFromWhiteToBlack
  end

  def previous
  end

end
