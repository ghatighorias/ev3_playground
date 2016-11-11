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

  def move_from_black_to_white(forward)
    steps = 0;
    current_color = color_sensor.current_color

    while current_color != 'White'
      move_in_direction(forward)
      steps++
      current_color = color_sensor.current_color
    end

    return steps;
  end

  def move_from_white_to_black(forward)
    steps = 0;
    current_color = color_sensor.current_color

    while current_color != 'Black'
      move_in_direction(forward)
      steps++
      current_color = color_sensor.current_color
    end

    return steps
  end

  def safe_move_to_black(forward)
    move_from_white_to_black(forward)
    steps = move_from_black_to_white(forward)
    move_in_direction_times(!forward, (steps / 2))
  end

  def next_position
    move_from_black_to_white(true)
    safe_move_to_black(true)
  end

  def previous_position
    move_from_black_to_white(false)
    safe_move_to_black(false)
  end

  def change_position_in_direction(direction_is_forward, change_time)
    change_time.times do
      if direction_is_forward
        next_position
      else
        previous_position
      end
    end
  end
end
