require_relative '../test_helper'

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_robot
    create_robots(1)

    robot = robot_world.find(robot_world.all.first.id)

    assert_equal "a name 1", robot.name
    assert_equal "a city 1", robot.city
    assert_equal "a state 1", robot.state
    assert_equal "a avatar 1", robot.avatar
    assert_equal "a birthdate 1", robot.birthdate
    assert_equal "a date_hired 1", robot.date_hired
    assert_equal "a department 1", robot.department
  end

  def test_can_find_all_robots
    create_robots

    robots = robot_world.all
    robot_one = robot_world.find(robot_world.all.first.id)
    robot_two = robot_world.find(robot_world.all.last.id)

    assert robots.is_a?(Array)
    assert_equal 'a name 1', robot_one.name
    assert_equal 'a name 2', robot_two.name
  end

  def test_can_find_a_robot
    create_robots(1)

    robot = robot_world.find(robot_world.all.first.id)

    assert_equal "a name 1", robot.name
    assert_equal "a city 1", robot.city
  end

  def test_can_update_robot
    create_robots(1)
    robot_world.update(
      robot_world.all.first.id,
      {
        :name => "a new name",
        :city => "a new city"
      })

    robot = robot_world.find(robot_world.all.first.id)
    assert_equal "a new name", robot.name
    assert_equal "a new city", robot.city
  end

  def test_can_destroy_robot
    create_robots(1)

    robot = robot_world.find(robot_world.all.first.id)
    assert_equal "a name 1", robot.name
    assert_equal "a city 1", robot.city

    robot_world.destroy(robot_world.all.first.id)
    begin
      robot_world.find(robot_world.all.first.id)
    rescue NoMethodError
      assert true
    else
      refute true
    end


  end
end
