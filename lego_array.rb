require './motor'
require './color_sensor'
require './movement_helper'

class LegoArray
  attr_reader :array

  def initialize(array, starting_position)
    @array = array
    @background_color = 'White'
    @target_color = 'Black'
    @movement_helper = MovementHelper.new(@background_color, @target_color)
    @current_array_index = starting_position
  end

  def go_to(requested_index)
    return unless is_index_in_range(index)

    move_safely = true
    steps = abs(requested_index - @current_array_index)
    is_forward = is_direction_forward(requested_index, @current_array_index)
    @movement_helper.change_position_in_direction(is_forward, steps, move_safely)

    @current_array_index = requested_index
  end

  def is_index_in_range(index)
    return if index >= -1 and index < @array.length
  end

  def is_direction_forward(requested_index, current_index)
    return requested_index > current_index
  end
end
