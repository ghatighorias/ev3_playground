require './motor'
require './color_sensor'

class LegoArray
  attr_reader :motor, :color_sensor, :array

  def moveFromBlackToWhite(toForward = true)
    while current_color == 'Black'
      if toForward
        motor.move_forward
      else
        motor.move_backward
      end
      current_color = color_sensor.current_color
    end
  end

  def moveFromWhiteToBlack(toForward = true)
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
    moveFromBlackToWhite(true)

    moveFromWhiteToBlack(true)
  end

  def previous
    moveFromBlackToWhite(false)

    moveFromWhiteToBlack(false)
  end

end
