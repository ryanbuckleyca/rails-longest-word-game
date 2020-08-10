class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    if letters_match_grid? && word_is_english?
      session[:player_points] = session[:player_points] + @guess.length.square
    end
    @points = session[:player_points]
    @result = result_message
  end

  private

  def result_message
    if letters_match_grid? && word_is_english?
      "<strong>Congratulations!</strong> #{@guess} is a valid English word! Your score is #{@points}"
    elsif !letters_match_grid?
      "Sorry but <strong>#{@guess}</strong> can't be built out of #{@letters.chars.join(', ')}"
    elsif !word_is_english?
      "Sorry but <strong>#{@guess}</strong> does not seem to be a valid English word..."
    end
  end

  def word_is_english?
    url = "https://wagon-dictionary.herokuapp.com/#{params['guess']}"
    word = JSON.parse(open(url).read)
    word['found']
  end

  def letters_match_grid?
    @guess = params['guess'].upcase
    @letters = params['letters']
    grid = @letters.chars
    @guess.chars.each do |letter|
      i = grid.find_index(letter)
      return false if i.nil?

      grid.delete_at(i)
    end
  end
end
