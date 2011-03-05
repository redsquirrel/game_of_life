require "game"

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