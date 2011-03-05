require "set"

def step(living)
  universe = all_cells(living)
  dead = universe - Set.new(living)
  new_living = dead.select { |point| alive?(live_neighbor_count(point, living), false) }
  new_living + living.select { |point| alive?(live_neighbor_count(point, living), true) }
end

describe "one step" do
  it "a block will remain a block" do
    block = [[2,2], [3,2], [2,3], [3,3]]
    step(block).should == block
  end
  
  it "an oscillator will oscillate" do
    horizontal = [[2,3], [3,3], [4,3]]
    vertical = [[3,2], [3,3], [3,4]]
    step(horizontal).should == vertical
  end
end