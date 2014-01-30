require 'spec_helper'

include Ants

describe Grid do
  SIZE = 5
  let!(:grid) { Grid.build(SIZE, SIZE){|x,y| nil} }

  it "exposes additional helper methods" do
    expect(grid).to respond_to(:[]=, :set, :sample, :sample_position, :size, :to_s, :sample_nil_position)
  end

  it "is mutable and exposes []= method" do
    expect { grid[0,0] = "a new item" }.to_not raise_error
    expect { grid.set({x: 0, y: 0}, "a new item") }.to_not raise_error
  end

  it "is always a square and returns it's size as it's height/width" do
    expect(grid.square?).to eq(true)
    expect(grid.size).to eq(SIZE)
  end
end
