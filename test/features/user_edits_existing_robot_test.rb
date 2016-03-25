require_relative '../test_helper'

class UserEditsAnExistingRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_edit_robot
    create_robots(1)
    visit '/robots/1'
    click_link("Edit")

    fill_in 'robot[name]', with: 'EDITED'
    fill_in 'robot[city]', with: "EDIT"
    fill_in 'robot[state]', with: 'EDIT'
    fill_in 'robot[avatar]', with: 'slkdjfhlskdjhf'
    fill_in 'robot[birthdate]', with: 'EDITED'
    fill_in 'robot[date_hired]', with: 'EDITED'
    fill_in 'robot[department]', with: 'EDITED'
    click_button 'submit'

    save_and_open_page
    within('#robot') do
      assert page.has_content?("fred")
    end
  end
end
