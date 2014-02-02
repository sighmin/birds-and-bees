require 'spec_helper'

include Ants::Colony

describe Ant do
  let(:algorithm) { Ants::Algorithm::CemeteryFormation.new({}, TEST_CONFIG) }
  let(:grid)      { algorithm.grid }
  let(:ant) do
    a = Ant.new(algorithm.config, {x: 0, y: 1}, grid)
    grid.place([a])
    a
  end

  let(:laden_ant) do
    a = Ant.new(algorithm.config, {x: 1, y: 0}, grid)
    i = Ants::Colony::UserItem.new
    a.item = i
    grid.place([a, i])
    a
  end

  it "exposes two ant behaviours" do
    expect(ant).to respond_to(:perceive_and_act, :move)
  end

  it "exposes helper methods" do
    expect(ant).to respond_to(:x, :y, :position, :print)
  end

  describe "methods" do
    it "#print returns a representative string" do
      expect(ant.print).to eq("x")
    end

    it "#position returns the position hash" do
      expect(ant.position).to eq({x: 0, y: 1})
    end

    it "#perceive_and_act"

    describe "protected" do
      it "#unladen? tells me if the ant carries an item" do
        expect(laden_ant.send(:unladen?)).to eq(false)
        expect(ant.send(:unladen?)).to eq(true)
      end

      it "#laden? tells me if the ant carries an item" do
        expect(laden_ant.send(:laden?)).to eq(true)
        expect(ant.send(:laden?)).to eq(false)
      end

      it "#walk_towards moves the ant onto the position" do
        destination = {x:0,y:0}
        ant.send(:walk_towards, destination)
        expect(ant.position).to eq(destination)
        expect(grid.get(destination)).to eq(ant)
      end

      it "#pickup_item removes the item from the grid" do
        new_ant = Ants::Colony::Ant.new(algorithm.config, {x:0,y:0}, grid)
        new_item = Ants::Colony::Item.new()
        grid.place([new_ant])
        grid.place([new_item])
        new_ant.send(:pickup_item)
        expect(new_ant.item).to eq(new_item)
        expect(grid.get(new_ant.position)).to be(new_ant)
      end

      it "#drop_item places a carried item onto the grid" do
        new_item = Ants::Colony::Item.new()
        new_ant = Ants::Colony::Ant.new(algorithm.config, {x:0,y:0}, grid)
        new_ant.item = new_item
        grid.place([new_ant])
        grid.place([new_item])
        new_ant.send(:drop_item)
        expect(grid.get(new_ant.position)).to be(new_item)
        expect(new_ant.item).to be_nil
      end
    end
  end
end
