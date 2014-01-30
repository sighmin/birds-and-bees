require 'spec_helper'

include Ants::Sims

describe Simulation do

  context "on the sad path" do
    let(:simulation) { Simulation.new }
    it "fails nicely and logs appropriately" do
      simulation.algorithm.stub(:run) { raise StandardError.new "Test error" }
      expect { simulation.start }.to_not raise_error
    end
  end

  context "on the happy path" do
    let(:simulation) { Simulation.new }
    it "completes a run of the algorithm" do
      expect(simulation.start).to eq(true)
    end
  end

end
