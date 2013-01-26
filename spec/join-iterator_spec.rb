require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "JoinIterator" do
  it "should do the basic joining" do
    a = [[1,11], [2,11], [3,13]]
    b = [[1,22],         [3,23]]
    c = [                [3,33]]

    expected = [
      [ 1, [11,  22, nil] ],
      [ 2, [11, nil, nil] ],
      [ 3, [13,  23,  33] ]
    ]

    result = []
    
    join_sorted([a,b,c]) do |line|
      result << line
    end

    result.should == expected
  end

  it "should be ok with empty arrays" do
    a = [[1,11], [2,11], [3,13]]
    b = []
    c = [                [3,33]]

    expected = [
      [ 1, [11, nil, nil] ],
      [ 2, [11, nil, nil] ],
      [ 3, [13, nil,  33] ]
    ]

    result = []
    
    join_sorted([a,b,c]) do |line|
      result << line
    end

    result.should == expected
  end

end
