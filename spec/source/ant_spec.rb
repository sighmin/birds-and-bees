require 'spec_helper'

include Ants::Colony

describe Ant do
  TEST_CONFIG = 'spec/support/test_config.yml'

  let(:algorithm) { Ants::Algorithm::CemeteryFormation.new({}, TEST_CONFIG) }
  let(:grid)      { algorithm.grid }
  let(:ant)       { Ant.new(algorithm.config, {x: 0, y: 1}, grid) }

  it "exposes two ant behaviours" do
    expect(ant).to respond_to(:x, :y, :position, :perceive_and_act, :move, :print)
  end

  describe "methods" do
    it "#print returns a representative string" do
      expect(ant.print).to eq("x")
    end
  end
end
