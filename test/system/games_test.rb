# frozen_string_literal: true

require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'Going to /new gives us a new random grid to play with' do
    visit new_url
    assert test: 'New game'
    assert_selector 'li', count: 10
  end

  test 'Fill form with random word, click the play, get message that word is not in grid' do
    visit new_url
    fill_in 'guess', with: 'xcslkasd'
    click_on 'play'

    assert_text(/^Sorry but .+ can't be built out of .+/)
  end

  test 'Fill form with one-letter consonant, click play, get message not valid English word' do
    visit new_url
    letter = page.find('input[name="letters"]').sub(/aeiou/, '').sample
    fill_in 'guess', with: letter
    click_on 'play'

    assert_text(/^Sorry but .+ does not seem to be a valid English word.../)
  end

  test 'Fill form with valid word, click play and get “Congratulations” message' do
    # TODO
  end
end
