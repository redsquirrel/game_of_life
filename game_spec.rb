require "set"

def step(living)
  universe = all_cells(living)
  dead = universe - living
  new_living = dead.select { |cell| alive?(live_neighbor_count(cell, living), false) }
  new_living += living.select { |cell| alive?(live_neighbor_count(cell, living), true) }
  Set.new(new_living)
end

def all_cells(living)
  living.inject(Set.new) do |universe, cell|
    universe + neighbors_for(cell) + [cell]
  end
end

def alive?(live_neighbor_count, currently_alive)
  if currently_alive
    live_neighbor_count == 2 || live_neighbor_count == 3
  else
    live_neighbor_count == 3
  end
end

def live_neighbor_count(cell, living)
  Set.new(neighbors_for(cell)).intersection(living).size
end

def neighbors_for(cell)
  my_x, my_y = cell
  neighbors = []
  SHIFTERS.each do |y|
    SHIFTERS.each do |x|
      neighbors << [my_x + x, my_y + y]
    end
  end
  neighbors - [cell]
end

SHIFTERS = [-1, 0, 1]

describe "one step" do
  it "a block will remain a block" do
    block = Set.new([[2,2], [3,2], [2,3], [3,3]])
    step(block).should == block
  end
  
  it "an oscillator will oscillate" do
    horizontal = Set.new([[2,3], [3,3], [4,3]])
    vertical = Set.new([[3,2], [3,3], [3,4]])
    step(horizontal).should == vertical
  end
end