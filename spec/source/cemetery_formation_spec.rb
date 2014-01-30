require 'spec_helper'

include Ants::Algorithm

describe CemeteryFormation do

  describe "initial state" do
    let(:algorithm) { CemeteryFormation.new('spec/support/test_config.yml', {iterations: 1}) }

    it "has default, but overridable configuration" do
      expect(algorithm.config).to_not be_nil
      expect(algorithm.config).to eq(
        gridsize: 20,
        iterations: 1,
        colonysize: 25,
        patchsize: 2
      )
    end

    it "has variables initialized from config" do
      expect(algorithm).to respond_to(:config, :ants, :items, :grid)

      expect(algorithm.grid.row_count).to eq(20)
      expect(algorithm.grid.square?).to   eq(true)
      expect(algorithm.ants.length).to    be > 0
      expect(algorithm.items.length).to   be > 0
    end
  end

  describe "methods" do
    it "can run" do

    end
  end

end
