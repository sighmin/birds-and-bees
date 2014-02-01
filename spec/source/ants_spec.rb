require 'spec_helper'

describe Ants do
  PARAMETERS = 'spec/support/test_config.yml'

  it "has a test method" do
    expect(Ants.test).to_not be_nil
  end

  it "has a version" do
    expect(Ants::VERSION).to_not be_nil
  end

  it "can parse yml" do
    expect(Ants::parse_yml(PARAMETERS)).to_not be_nil
  end
end
