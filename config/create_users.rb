#!/usr/bin/env ruby

# Requirements
require 'faker'
# Monkey patch for convenience
class Array
  def sample_ratio(percentage)
    sample(percentage * length)
  end
end

# Configurations
I18n.enforce_available_locales = false
ARGV.map! {|arg| arg.to_i}
NUM_USERS = ARGV.shift || 25

# Categories setup
music_pool = %w{acoustic punk blues gospel classical western dance emo folk indie hiphop jazz metal ska spoken}
sport_pool = %w{cricket rugby pool tennis golf racing biking soccer basketball dodgeball darts netball swimming athletics boxing}
food_pool  = %w{pizza pasta burgers fried-chicken cereal steak potatoes boerewors chocolate smoothies bread bacon rusks cake wine}
tech_pool  = %w{apple google platform45 html slim sass coffeescript griffin ruby rails artificial-intelligence facebook twitter tumbler google-plus}
targets    = %w{muso sporty foodie geek}

# Interest level setup
primary      = 0.8
average1     = 0.3
average2     = 0.2
uninterested = 0.0
distribution = [primary, average1, average2, uninterested]

# Generation loop
users = []
NUM_USERS.times do |i|
  dist = distribution.shuffle
  users << {
    name: Faker::Name.name,
    interests: {
      music: music_pool.sample_ratio(dist[0]),
      sport: sport_pool.sample_ratio(dist[1]),
      food: food_pool.sample_ratio(dist[2]),
      tech: tech_pool.sample_ratio(dist[3])
    },
    target: targets[dist.index(dist.max)]
  }
end

# Persist generated users
File.open('config/mock_users.yml', 'w+') do |file|
  users.each do |user|
    file.write(user.to_yaml + "\n")
  end
end
