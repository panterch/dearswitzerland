require "application_system_test_case"

class LettersTest < ApplicationSystemTestCase
  setup do
    @letter = letters(:one)
  end

  test "visiting the index" do
    visit letters_url
    assert_selector "h1", text: "Letters"
  end

  test "creating a Letter" do
    visit letters_url
    click_on "New Letter"

    check "Anonymous" if @letter.anonymous
    fill_in "Email", with: @letter.email
    fill_in "Lang", with: @letter.lang
    fill_in "Last name", with: @letter.last_name
    check "Newsletter" if @letter.newsletter
    check "Online" if @letter.online
    fill_in "Pre name", with: @letter.pre_name
    check "Print" if @letter.print
    check "Recall" if @letter.recall
    fill_in "Zip", with: @letter.zip
    click_on "Create Letter"

    assert_text "Letter was successfully created"
    click_on "Back"
  end

  test "updating a Letter" do
    visit letters_url
    click_on "Edit", match: :first

    check "Anonymous" if @letter.anonymous
    fill_in "Email", with: @letter.email
    fill_in "Lang", with: @letter.lang
    fill_in "Last name", with: @letter.last_name
    check "Newsletter" if @letter.newsletter
    check "Online" if @letter.online
    fill_in "Pre name", with: @letter.pre_name
    check "Print" if @letter.print
    check "Recall" if @letter.recall
    fill_in "Zip", with: @letter.zip
    click_on "Update Letter"

    assert_text "Letter was successfully updated"
    click_on "Back"
  end

  test "destroying a Letter" do
    visit letters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Letter was successfully destroyed"
  end
end
