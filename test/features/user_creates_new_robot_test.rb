require_relative '../test_helper'

class UserSeesGreetingOnHomepage < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_create_a_robot
    visit '/'
    click_link("New Robot")

    fill_in 'robot[name]', with: 'fred'
    fill_in 'robot[city]', with: "LA"
    fill_in 'robot[state]', with: 'CA'
    fill_in 'robot[avatar]', with: 'slkdjfhlskdjhf'
    fill_in 'robot[birthdate]', with: '1234'
    fill_in 'robot[date_hired]', with: '4567'
    fill_in 'robot[department]', with: 'anchor'
    click_button 'submit'

    within('#robot') do
      assert page.has_content?("fred")
    end
  end
end
