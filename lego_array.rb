require './motor'
require './color_sensor'

class LegoArray
  attr_reader :motor, :color_sensor, :array

  def move_from_black_to_white(toForward = true)
    current_color = color_sensor.current_color
    while current_color != 'White'
      if toForward
        motor.move_forward
      else
        motor.move_backward
      end
      current_color = color_sensor.current_color
    end
  end

  def move_from_white_to_black(toForward = true)
    current_color = color_sensor.current_color
    while current_color != 'Black'
      if toForward
        motor.move_forward
      else
        motor.move_backward
      end
      current_color = color_sensor.current_color
    end
  end

  def initialize(array, starting_position) #{-1 .. 4}
    @motor = Motor.new
    @color_sensor = ColorSensor.new
    @array = array
    @current_array_index = starting_position
  end

  def next_position
    move_from_black_to_white(true)
    move_from_white_to_black(true)
  end

  def previous_position
    move_from_black_to_white(false)
    move_from_white_to_black(false)
  end

 def go_to(index)
   return if index < -1 and index >= @array.length

   steps = index - @current_array_index

   if (steps < 0)
     steps.abs.times do
       previous_position
     end
   else
     steps.times do
       next_position
     end
   end

  @current_array_index = index
 end

end
