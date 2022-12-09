require "application_system_test_case"

class SantaTest < ApplicationSystemTestCase
  setup do
    @santum = santa(:one)
  end

  test "visiting the index" do
    visit santa_url
    assert_selector "h1", text: "Santa"
  end

  test "creating a Santum" do
    visit santa_url
    click_on "New Santum"

    fill_in "Email", with: @santum.email
    fill_in "Give to", with: @santum.give_to
    fill_in "Nickname", with: @santum.nickname
    fill_in "User", with: @santum.user_id
    click_on "Create Santum"

    assert_text "Santum was successfully created"
    click_on "Back"
  end

  test "updating a Santum" do
    visit santa_url
    click_on "Edit", match: :first

    fill_in "Email", with: @santum.email
    fill_in "Give to", with: @santum.give_to
    fill_in "Nickname", with: @santum.nickname
    fill_in "User", with: @santum.user_id
    click_on "Update Santum"

    assert_text "Santum was successfully updated"
    click_on "Back"
  end

  test "destroying a Santum" do
    visit santa_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Santum was successfully destroyed"
  end
end
