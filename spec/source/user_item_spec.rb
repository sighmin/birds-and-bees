require 'spec_helper'

include Ants::Colony

describe UserItem do
  let(:item) do
    UserItem.new({x: 0, y: 0}, {
      name: "Test User 1",
      interests: {
        music: [],
        sport: ["golf", "rugby", "dodgeball"],
        food: ["bread", "bacon", "rusks", "cake"],
        tech: ["artificial-intelligence", "tumbler", "platform45", "griffin", "facebook", "html", "ruby", "twitter", "rails", "google-plus", "sass", "apple"]
      },
      target: "geek"
    })
  end

  let(:similar_item) do
    UserItem.new({x: 0, y: 1}, {
      name: "Similar User",
      interests: {
        music: ["dance", "emo", "western", "classical"],
        sport: ["golf", "dodgeball", "netball"],
        food: [],
        tech: ["griffin", "artificial-intelligence", "html", "coffeescript", "google", "twitter", "ruby", "sass", "google-plus", "rails", "slim", "facebook"]
      },
      target: "geek"
    })
  end

  let(:dissimilar_item) do
    UserItem.new({x: 1, y: 0}, {
      name: "Dissimilar User",
      interests: {
        music: ["classical", "metal", "jazz", "dance", "blues", "folk", "punk", "gospel", "western", "acoustic", "ska", "indie"],
        sport: [],
        food: ["wine", "fried-chicken", "potatoes", "boerewors"],
        tech: ["apple", "tumbler", "facebook"]
      },
      target: "muso"
    })
  end

  it "has helper methods" do
    expect(item).to respond_to(:x, :y, :data, :position, :print)
    expect(UserItem).to respond_to(:pickup_probability, :drop_probability, :dissimilarity, :local_density)
  end

  describe "methods" do

    it ".pickup_probability"

    it ".drop_probability"

    describe "protected" do

      it ".local_density"

      it ".dissimilarity returns a measure between user items" do
        similar = UserItem.send(:dissimilarity, item, similar_item)
        dissimilar = UserItem.send(:dissimilarity, item, dissimilar_item)
        expect(similar).to be > 0.5
        expect(dissimilar).to be < 0.5
      end
    end
  end
end
