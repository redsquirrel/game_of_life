require "game"

def render(cells, living)
  vertically_sorted = cells.sort_by {|cell| cell[1]}
  horizontally_sorted = cells.sort_by {|cell| cell[0]}

  top = vertically_sorted.first
  bottom = vertically_sorted.last
  left = horizontally_sorted.first
  right = horizontally_sorted.last
  
  top_left = [left[0], top[1]]
  bottom_right = [right[0], bottom[1]]
    
  @original_top_left ||= top_left
  @original_bottom_right ||= bottom_right
  
  bottom_right_to_use = [bottom_right, @original_bottom_right].sort_by {|cell| cell[1]}.last  
  width = bottom_right_to_use[0] - @original_top_left[0]
  puts "-" * width
  
  @original_top_left[1].upto(bottom_right_to_use[1]) do |y|
    @original_top_left[0].upto(bottom_right_to_use[0]) do |x|
      if living.include?([x, y])
        print "O"
      else
        print " "
      end
    end
    puts
  end
end

# living = Set.new([[2,3], [3,3], [4,3]]) # oscillator
# living = Set.new([[2,2], [3,2], [2,3], [3,3]]) # block
living = Set.new([[2, 3], [3, 3], [4, 3], [4, 2], [3, 1]]) # glider
# living = Set.new([[2, 3], [3, 3], [4, 3], [4, 4], [3, 5]]) # inverted glider

until living.empty?
  render(all_cells(living), living)
  living = step(living)
  sleep 0.2
end
