require 'spec_helper'

include Ants::Algorithm

describe CemeteryFormation do

  describe "initial state" do
    let(:algorithm) do
      CemeteryFormation.new({iterations: 1}, TEST_CONFIG)
    end

    it "has default, but overridable configuration" do
      expect(algorithm.config).to_not be_nil
      expect(algorithm.config).to eq(
        gridsize:   20,
        iterations: 1,
        colonysize: 5,
        patchsize:  2,
        print_resolution: 50
      )
    end

    it "has variables initialized from config" do
      expect(algorithm).to respond_to(:config, :ants, :items, :grid, :dataset)

      expect(algorithm.grid.row_count).to eq(20)
      expect(algorithm.grid.square?).to   eq(true)
      expect(algorithm.ants.length).to    be > 0
      expect(algorithm.items.length).to   be > 0
    end
  end

  describe "methods" do
    let(:algorithm) do
      CemeteryFormation.new({}, TEST_CONFIG)
    end

    it "#run begins the algorithm"

    it "#find_hidden_ants reveals ants after an item has moved off of a site"
  end
end
