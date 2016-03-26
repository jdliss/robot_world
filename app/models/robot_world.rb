require 'sequel'
require 'time'

class RobotWorld
  attr_reader :world,
              :robot_world

  def initialize(database)
    @world = database
    @robot_world = database.from(:robots)
  end

  def create(robot)
    robot_world.insert(robot)
  end

  def all
    raw_robots.map { |data| Robot.new(data) }
  end

  def raw_robots
    robot_world.select.to_a
  end

  def raw_robot(id)
    robot_world.where(id: id).to_a.first
  end

  def find(id)
    Robot.new(robot_world.where(id: id).to_a.first)
  end

  def update(id, robot)
    robot_world.where(id: id).update(robot)
  end

  def destroy(id)
    robot_world.where(id: id).delete
  end

  def destroy_all
    robot_world.delete
  end

  def average_robot_age
    birthdates = world.select(:birthdate).from(:robots)
    ages = birthdates.map do |pair|
      2016 - Time.parse(pair[:birthdate]).strftime("%Y").to_i
    end
    (ages.reduce(:+)/ages.size.to_f).round(1)
  end

  def num_hired_each_year
    years = world.select(:date_hired).from(:robots)
    hired_each_year = Hash.new(0)
    years.each do |year|
      formatted_year = Time.parse(year[:date_hired]).strftime("%Y")
      hired_each_year[formatted_year] += 1
    end
    hired_each_year.sort.reverse
  end

  def num_robots_in(symbol)
    data = world.select(symbol).from(:robots)
    counted_data = Hash.new(0)
    # require 'pry'; binding.pry
    data.each do |item|
      counted_data[item[symbol].capitalize] += 1
    end
    counted_data
  end

  def total_robots
    robot_world.to_a.size
  end
end
