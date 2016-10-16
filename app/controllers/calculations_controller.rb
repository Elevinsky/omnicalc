class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

@sanitized_text = @text.gsub(" ", "")
@sanitized_special = @text.gsub(@special_word, "")
@text_array = @text.split(' ')

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @sanitized_text.length

    @word_count = @text_array.length

    @occurrences = @text_array.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f


    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@apr/1200 * @principal) / (1-(1+(@apr/1200)) ** (-12 * @years))
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @days / (365.25)


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count-1]

    @range = @maximum - @minimum

    if @count.even? == true
      @median = (@sorted_numbers[(@count-1)/2] + @sorted_numbers[(@count+1)/2])/2
    elsif @count.odd? == true
      @median = @sorted_numbers[((@count+1)/2)-1]
    end

    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end

      return running_total
    end

    @sum = sum(@numbers)

    @mean = @sum/@count

    def sqmean(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + (number-@mean)**2
      end

      return running_total
    end

    @variance = sqmean(@numbers)/@count

    @standard_deviation = @variance**0.5

    @mode_array = []
    @starting = 0
    @winning_count = 0
    @winning_number = 0
    while @starting < 3
      @mode_array.push(2)
      @starting = @starting + 1
    #   if @sorted_numbers.count(@sorted_numbers[@starting]) > @winning_count
    #     @mode_array.push(2)
    #   @starting = @starting + 1
    # elsif @sorted_numbers.count(@sorted_numbers[@starting]) < @winning_count
    #   @mode_array.push(1)
    #   @starting = @starting + 1
    # end
  end

    @mode = @mode_array

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
