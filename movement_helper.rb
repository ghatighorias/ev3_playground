require './motor'
require './color_sensor'

class MovementHelper
  attr_reader :motor, :color_sensor, :array

  def initialize()
    @motor = Motor.new
    @color_sensor = ColorSensor.new
  end

  def move_in_direction(forward)
    if forward
      motor.move_forward
    else
      motor.move_backward
    end
  end

  def move_in_direction_times(forward, cycle)
    cycle.times do
      move_in_direction(forward)
    end
  end

  def move_unless_see_color(forward, color)
    steps = 0;
    current_color = color_sensor.current_color

    while current_color != color
      move_in_direction(forward)
      steps++
      current_color = color_sensor.current_color
    end

    return steps;
  end

  def move_from_black_to_white(forward)
    return move_till_color(forward, 'White')
  end

  def move_from_white_to_black(forward)
    return move_till_color(forward, 'Black')
  end

  def safe_move_to_black(forward)
    move_from_white_to_black(forward)
    steps = move_from_black_to_white(forward)
    move_in_direction_times(!forward, (steps / 2))
  end

  def next_position(move_safely)
    move_from_black_to_white(true)

    if(move_safely)
      safe_move_to_black(true)
    else
      move_from_white_to_black(true)
    end
  end

  def previous_position(move_safely)
    move_from_black_to_white(false)

    if(move_safely)
      safe_move_to_black(false)
    else
      move_from_white_to_black(false)
    end
  end

  def change_position_in_direction(direction_is_forward, change_time, move_safely)
    change_time.times do
      if direction_is_forward
        next_position(move_safely)
      else
        previous_position(move_safely)
      end
    end
  end
end
