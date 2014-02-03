require 'spec_helper'

describe Ants do

  it "has a test method" do
    expect(Ants.test).to_not be_nil
  end

  it "has a version" do
    expect(Ants::VERSION).to_not be_nil
  end

  it "can parse a yml file" do
    expect(Ants::parse_yml(TEST_CONFIG)).to_not be_nil
  end

  it "can parse a array of yml in a file" do
    expect(Ants::parse_array_yml(MOCK_USERS)).to be_a(Array)
  end
end
