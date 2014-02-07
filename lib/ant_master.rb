#!/usr/bin/env ruby

require 'yaml'
require 'pry'
require 'matrix'
require 'ants/version'
require 'ants'

# Entry point here
include Ants

simulation = Sims::Simulation.new
simulation.start

