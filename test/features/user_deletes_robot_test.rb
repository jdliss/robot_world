require_relative '../test_helper'

class UserDeletesRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_delete_robot
    create_robots(1)
    visit '/robots/1'
    click_button("delete")

    refute page.has_content?("#robot")
  end
end
