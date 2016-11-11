require './motor'
require './color_sensor'

class MovementHelper
  attr_reader :motor, :color_sensor, :array

  def initialize(background_color, target_color)
    @motor = Motor.new
    @color_sensor = ColorSensor.new
    @background_color = background_color
    @target_color = target_color
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

  def move_unless_see_target(forawrd)
    return move_till_color(forward, @target_color)
  end

  def move_unless_see_background(forawrd)
    return move_till_color(forward, @background_color)
  end

  def safe_move_to_target(forward)
    move_unless_see_target(forward)
    steps = move_unless_see_background(forward)
    move_in_direction_times(!forward, (steps / 2))
  end

  def move_one_block(forawrd, move_safely)
    move_unless_see_background(forawrd)

    if(move_safely)
      safe_move_to_target(forawrd)
    else
      move_unless_see_target(forawrd)
    end
  end

  def next_position(move_safely)
    move_one_block(true, move_safely)
  end

  def previous_position(move_safely)
    move_one_block(false, move_safely)
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
