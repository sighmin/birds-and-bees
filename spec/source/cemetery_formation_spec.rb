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
  end

  describe "methods" do
    it "can run" do

    end
  end
end
