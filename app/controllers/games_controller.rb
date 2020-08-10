require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10).join(' ')
  end

  def check_word
    @answer = params[:choice]
    answers = @answer.split('')
    answers.all? { |answer| @word.include?(answer) }
  end

  def english_word
    @word = params[:random_letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    word['found']
  end

  def score
    full_word = @word.each_char { |letter| print letter, '' }
    if check_word == false
      @result = "Sorry, but #{@answer.upcase} can’t be built out of #{full_word.upcase}."
    elsif english_word == false
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    elsif check_word && english_word == false
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    else check_word && english_word == true
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    end
  end
end
