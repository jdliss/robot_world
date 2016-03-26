ENV['RACK_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'tilt/erb'
require 'capybara/dsl'
require 'sequel'

Capybara.app = RobotWorldApp

module TestHelpers
  def teardown
    robot_world.destroy_all
    super
  end

  def robot_world
    world = Sequel.sqlite("db/robot_world_test.sqlite3")
    @robot_world ||= RobotWorld.new(world)
  end

  def create_robots(num = 2)
    num.times do |i|
      robot_world.create({
        :name       => "a name #{i + 1}",
        :city       => "a city #{i + 1}",
        :state      => "a state #{i + 1}",
        :avatar     => "a avatar #{i + 1}",
        :birthdate  => "a birthdate #{i + 1}",
        :date_hired => "a date_hired #{i + 1}",
        :department => "a department #{i + 1}"
      })
    end
  end
end
