require './motor'
require './color_sensor'
require './movement_helper'
class LegoArray
  attr_reader :motor, :color_sensor, :array

  def initialize(array, starting_position)
    @array = array
    @movement_helper = MovementHelper.new
    @current_array_index = starting_position
  end

  def go_to(index)
    return unless is_index_in_range(index)

    steps = abs(index - @current_array_index)
    direction_is_forward = is_direction_forward(index, @current_array_index)
    @movement_helper.change_position_in_direction(direction_is_forward, steps)

    @current_array_index = index
  end

  def is_index_in_range(index)
    return if index >= -1 and index < @array.length #@array.length - 1
  end

  def is_direction_forward(requested_index, current_index)
    return requested_index > current_index
  end
end
