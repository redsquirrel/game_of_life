require "game"

describe "in a single step" do
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

describe "when we play the game" do
  it "an unviable pattern will die after two generations" do
    unviable = Set.new([[2,2], [3,2], [4,3]])
    count = 0
    counter = lambda { |_, _| count += 1 }
    play(unviable, &counter)
    count.should == 2
  end
end
