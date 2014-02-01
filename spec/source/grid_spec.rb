require 'spec_helper'

include Ants

describe Grid do
  SIZE = 5
  let(:grid) { Grid.build(SIZE, SIZE){|x,y| nil} }

  it "exposes additional helper methods" do
    expect(grid).to respond_to(:[], :[]=, :get, :set, :size, :place)
  end

  it "exposes grid specific helper methods" do
    expect(grid).to respond_to(:sample, :sample_position, :sample_nil_position, :to_s)
  end

  describe "methods" do
    let(:grid) do
      Grid.build(SIZE, SIZE){|x,y| (x == 0 && y == 0) ? "circular" : nil}
    end
    let(:small_grid) do
      grid = Grid.build(2,2){|x,y| nil }
      grid[0,0] = Ants::Colony::Item.new
      grid[1,1] = Ants::Colony::Ant.new(nil, {x:1, y:1})
      grid
    end

    it "#[] provides circular indexing" do
      out_of_bounds = {x: SIZE, y: SIZE}
      expect { grid[out_of_bounds[:x], out_of_bounds[:y]] }.to_not raise_error
      expect(grid[out_of_bounds[:x], out_of_bounds[:y]]).to eq("circular")
    end

    it "#[]= is mutable" do
      expect { grid[0,0] = "a new item" }.to_not raise_error
      expect { grid.set({x: 0, y: 0}, "a new item") }.to_not raise_error
    end

    it "#get returns the value at the position" do
      expect(grid.get({x: 0, y: 0})).to eq("circular")
    end

    it "#set assigns the value at the position" do
      position = {x: SIZE-1, y: SIZE-1}
      grid.set(position, "botright")
      expect(grid.get(position)).to eq("botright")
    end

    it "#size returns width of the square matrix" do
      expect(grid.square?).to eq(true)
      expect(grid.size).to eq(SIZE)
    end

    it "#sample, #sample_position, #sample_nil_position work" do
      expect(grid.sample_position).to include(:x, :y)
      expect(grid.sample_position[:x]).to be >= 0
      expect(grid.sample_position[:x]).to be < SIZE
      expect(grid.sample_position[:y]).to be >= 0
      expect(grid.sample_position[:y]).to be < SIZE
      expect { grid.sample }.to_not raise_error
      expect(grid.get(grid.sample_nil_position)).to be_nil
    end

    it "#place assigns the values of the positional objects in the array" do
      pos1, pos2 = {x:0,y:SIZE-1}, {x:SIZE-1,y:0}
      item1, item2 = Ants::Colony::Item.new(pos1), Ants::Colony::Item.new(pos2)
      items = []
      items << item1
      items << item2
      grid.place(items)
      expect(grid.get(pos1)).to be(item1)
      expect(grid.get(pos2)).to be(item2)
    end

    it "#to_s prints a pretty grid" do
      grid = Grid.build(2,2){|x,y| nil }
      grid[0,0] = Ants::Colony::Item.new
      grid[1,1] = Ants::Colony::Ant.new(nil, {x:1, y:1})
      expect(grid.to_s).to eq("O . \n. x \n")
    end

    it "#adjacent_sites returns site positions with patchsize of 1" do
      position       = {x:0, y:0}
      expected_sites = [{x:0, y:1}, {x:1, y:0}, {x:1, y:1}, {x:SIZE-1, y:SIZE-1}, {x:0,y:SIZE-1}, {x:1,y:SIZE-1}, {x:SIZE-1,y:0}, {x:SIZE-1,y:1}]
      expect(grid.adjacent_sites(position)).to match_array(expected_sites)
    end

    it "#neighbors returns adjacent sites within patchsize" do
      position         = {x:1, y:1}
      patchsize        = 2
      horizontal_sites = [{x:1,y:0}, {x:1,y:SIZE-1}, {x:1,y:2}, {x:1,y:3}, {x:2,y:1}, {x:3,y:1}, {x:0,y:1},{x:SIZE-1,y:1}]
      diag1_sites      = [{x:0,y:0}, {x:0,y:SIZE-1}, {x:SIZE-1,y:0}, {x:SIZE-1,y:SIZE-1}]
      diag2_sites      = [{x:2,y:0}, {x:2,y:SIZE-1}, {x:3,y:SIZE-1}, {x:3,y:0}]
      diag3_sites      = [{x:0,y:2}, {x:0,y:3}, {x:SIZE-1,y:2}, {x:SIZE-1,y:3}]
      diag4_sites      = [{x:2,y:2}, {x:3,y:2}, {x:2,y:3}, {x:3,y:3}]
      expected_sites   = horizontal_sites + diag1_sites + diag2_sites + diag3_sites + diag4_sites
      expect(grid.neighbors(position, patchsize)).to match_array(expected_sites)
    end

    it "#item_at? returns true if an item is found, else false" do
      item_position = {x:0, y:0}
      nil_position  = {x:0, y:1}
      expect(small_grid.item_at?(item_position)).to eq(true)
      expect(small_grid.item_at?(nil_position)).to eq(false)
    end

    it "#empty_at? returns true if no item is found, else false" do
      item_position = {x:0, y:0}
      nil_position  = {x:0, y:1}
      expect(small_grid.empty_at?(item_position)).to eq(false)
      expect(small_grid.empty_at?(nil_position)).to eq(true)
    end

    it "#move moves the object at first parameter position to second parameter position" do
      # moves item to nil
      small_grid.move({x:0,y:0},{x:1,y:0})
      expect(small_grid[0,0]).to be_nil
      expect(small_grid[1,0].kind_of?(Ants::Colony::Item)).to eq(true)
      # moves item to item => error raised
      small_grid.set({x:0, y:0}, Ants::Colony::UserItem.new)
      expect { small_grid.move({x:0, y:0}, {x:1, y:0}) }.to raise_error
      # moves ant to item
      small_grid.move({x:1, y:1}, {x:0, y:0})
      expect(small_grid[0,0].kind_of?(Ants::Colony::Item)).to eq(true)
      expect(small_grid[1,1]).to be_nil
    end
  end
end
