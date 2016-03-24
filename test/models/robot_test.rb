require_relative '../test_helper'

class RobotTest < Minitest::Test
  def test_assigns_attributes_correctly
    robot = Robot.new({ "id"         => 1,
                        "name"       => "a name",
                        "city"       => "a city",
                        "state"      => "a state",
                        "avatar"     => "a avatar",
                        "birthdate"  => "a birthdate",
                        "date_hired" => "a date_hired",
                        "department" => "a department"
                         })

    assert_equal 1, robot.id
    assert_equal "a name", robot.name
    assert_equal "a city", robot.city
    assert_equal "a state", robot.state
    assert_equal "a avatar", robot.avatar
    assert_equal "a birthdate", robot.birthdate
    assert_equal "a date_hired", robot.date_hired
    assert_equal "a department", robot.department
  end
end
