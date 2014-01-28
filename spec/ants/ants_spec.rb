require 'spec_helper'

describe Ants do
  it "has a test method" do
    expect(Ants.test).to_not be_nil
  end
  it "has a version" do
    expect(Ants::VERSION).to_not be_nil
  end
end
