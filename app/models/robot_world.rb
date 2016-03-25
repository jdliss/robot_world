require "yaml/store"

class RobotWorld
  attr_reader :world

  def initialize(database)
    @world = database
  end

  def create(robot)
    world.transaction do
      world['robots'] ||= []
      world['total']  ||= 0
      world['total']   += 1
      world['robots']  << { 'id'         => world['total'],
                            'name'       => robot['name'],
                            'city'       => robot['city'],
                            'state'      => robot['state'],
                            'avatar'     => robot['avatar'],
                            'birthdate'  => robot['birthdate'],
                            'date_hired' => robot['date_hired'],
                            'department' => robot['department']
                          }
    end
  end

  def all
    raw_robots.map { |data| Robot.new(data) }
  end

  def raw_robots
    world.transaction do
      world['robots'] || []
    end
  end

  def raw_robot(id)
    raw_robots.find { |robot| robot["id"].to_s == id }
  end

  def find(id)
    all.find { |robot|  robot.id == id }
  end

  def update(id, robot)
    world.transaction do
      target = world['robots'].find { |data| data["id"] == id }
      target["name"] = robot[:name]
      target["city"] = robot[:city]
      target['state'] = robot[:state]
      target['birthdate'] = robot[:birthdate]
      target['date_hired'] = robot[:date_hired]
      target['department'] = robot[:department]
    end
  end

  def destroy(id)
    world.transaction do
      world['robots'].delete_if { |robot| robot["id"] == id }
    end
  end

  def destroy_all
    world.transaction do
      world['robots'] = []
      world['total'] = 0
    end
  end
end
