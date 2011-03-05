require "game"

def render(cells, living)
  sorted_cells = sort(cells)
  upper_left = sorted_cells.first
  lower_right = sorted_cells.last
    
  @original_upper_left ||= upper_left
  @original_lower_right ||= lower_right
  
  lower_right_to_use = sort([lower_right, @original_lower_right]).last
  
  puts "---"
  @original_upper_left[1].upto(lower_right_to_use[1]) do |y|
    @original_upper_left[0].upto(lower_right_to_use[0]) do |x|
      if living.include?([x, y])
        print "O"
      else
        print " "
      end
    end
    puts
  end
end

def sort(cells)
  cells.sort do |a, b|
    x_eq = a[0] <=> b[0]
    x_eq == 0 ? a[1] <=> b[1]  : x_eq
  end
end

# living = Set.new([[2,3], [3,3], [4,3]]) # oscillator
# living = Set.new([[2,2], [3,2], [2,3], [3,3]]) # block
living = Set.new([[2, 3], [3, 3], [4, 3], [4, 2], [3, 1]]) # glider
until living.empty?
  render(all_cells(living), living)
  living = step(living)
  sleep 0.2
end
