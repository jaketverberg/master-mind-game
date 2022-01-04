module MasterMind
  COLOR_CHOICES = [["red"], ["green"], ["blue"], ["magenta"], ["cyan"], ["white"]]
  turns = 12

  class String
    def bg_red;         "\e[41m#{self}\e[0m" end
    def bg_green;       "\e[42m#{self}\e[0m" end
    def bg_blue;        "\e[44m#{self}\e[0m" end
    def bg_magenta;     "\e[45m#{self}\e[0m" end
    def bg_cyan;        "\e[46m#{self}\e[0m" end
    def bg_white;       "\e[47m#{self}\e[0m" end
  end

  class Game
    attr_reader :player_guess

    def initialize(player)
      temp_color_choice = []
      temp_color_choice[0] = "  ".bg_red
      temp_color_choice[1] = "  ".bg_green
      temp_color_choice[2] = "  ".bg_blue
      temp_color_choice[3] = "  ".bg_magenta
      temp_color_choice[4] = "  ".bg_cyan
      temp_color_choice[5] = "  ".bg_white
      all_color_choices = temp_color_choice

      computer_cipher_sequence = []
      4.times { |i| computer_cipher_sequence.push(temp_color_choice.delete_at(rand(temp_color_choice.length))) }
    end #end Game

    def play
      loop do
        #player selects their choices
        @player_guess = []
        player_guess_sequence()

        if player_has_won?
          puts "#{player.name} won! Way to go!"
          puts @player_guess
          return
        elsif
          turn == 0
          "Out of turns! You lost."
          return
        else
          turns - 1
          puts "#{turns} turn(s) left"
        end

        feedback()


        #for each color in computer_cipher_sequence
          #if color matches computer_cipher_sequence.color
            #feedback + red
          #else if color matches.any computer_cipher_sequence BUT NOT INDEX
            #feedback + white
          #else if color doesn't match.any? or index or computer_cipher_sequence
            #feedback + blank

    end #end play

    def feedback(@player_guess)
      #for each color in computer_cipher_sequence
          #if color matches computer_cipher_sequence.color
            #feedback + red
          #else if color matches.any computer_cipher_sequence BUT NOT INDEX
            #feedback + white
          #else if color doesn't match.any? or index or computer_cipher_sequence
            #feedback + blank
    end #end feedback

    def player_has_won?
      computer_cipher_sequence == @player_guess ? true : false
    end #end player_has_won?

    def player_guess_sequence()
      puts "#{player.name} pick 4 choices one at a time by typing from the selections below."
      COLOR_CHOICES.each { |color| puts color }
      puts "** type your choice like so - 'Red' **"

      loop do
        guess = gets.chomp.downcase

        COLOR_CHOICES.any? == guess ? @player_guess.push(guess) : puts "Not one of the choices, try again"
        if @player_guess.length == 4
          puts "Your guesses #{@player_guess.join('')}"
          return
        end
      end #end loop

      player_guess_text_to_color(@player_guess)
    end #player_guess_sequence

    def player_guess_text_to_color(guesses)
      guesses.map! do |text_color|
        case text_color
        when "red"
          text_color = "  ".bg_red
        when "green"
          text_color = "  ".bg_green
        when "blue" = "  ".bg_blue
        when "magenta" = "  ".bg_magenta
        when "cyan" = "  ".bg_cyan
        when "white" = "  ".bg_white
        end #end case
    end #end player_guess_text_to_color

  end #Game Class

  class Player
    attr_reader :name

    def initialize (name)
      @name = name
    end

  end

  class ComputerPlayer
  end

puts "Welcome to Master Mind"
puts "What is your name?"
