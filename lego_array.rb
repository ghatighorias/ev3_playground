require './motor'
require './color_sensor'
require './movement_helper'
class LegoArray
  attr_reader :motor, :color_sensor, :array

  def initialize(array, starting_position)
    @movement_helper = MovementHelper.new
    @array = array
    @current_array_index = starting_position
  end

  def go_to(index)
    return if index < -1 and index >= @array.length

    steps = abs(index - @current_array_index)
    direction_is_forward = index > @current_array_index

    @movement_helper.change_position_in_direction(direction_is_forward, steps)

    @current_array_index = index
  end

end
