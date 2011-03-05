def step(living_cells)
  living_cells
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