require 'faker'
require 'time'
require_relative '../app/models/robot_world'

class RobotWorldApp
  def robot_world
    world = Sequel.sqlite("db/robot_world.sqlite")
    @robot_world ||= RobotWorld.new(world)
  end
end


robot_world = RobotWorldApp.new.robot_world

def generate_robot
  robot = {
    :name       => Faker::Name.name,
    :city       => Faker::Address.city,
    :state      => Faker::Address.state,
    :avatar     => Faker::Avatar.image,
    :birthdate  => Faker::Date.birthday.strftime("%F"),
    :date_hired => Faker::Time.between(Faker::Date.birthday,Time.now).to_s[0..9],
    :department => Faker::Company.profession
  }
end

100.times do
  robot_world.create(generate_robot)
end
