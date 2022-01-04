module MasterMind
  COLOR_CHOICES = [["Red"], ["Green"], ["Blue"], ["Magenta"], ["Cyan"], ["White"]]
  TURNS = 12

  class String
    def bg_red;         "\e[41m#{self}\e[0m" end
    def bg_green;       "\e[42m#{self}\e[0m" end
    def bg_blue;        "\e[44m#{self}\e[0m" end
    def bg_magenta;     "\e[45m#{self}\e[0m" end
    def bg_cyan;        "\e[46m#{self}\e[0m" end
    def bg_white;       "\e[47m#{self}\e[0m" end
  end

  class Game
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
        player_guess_sequence
        #if choices match computer_Cipher_sequence
          #they win!
        if player_has_won?
          puts "#{player.name} won! Way to go!"
          puts computer_cipher_sequence
          return
        #if choices don't match computer_cipher_sequence turn - 1

        #if turn == 0, game over, player looses

        #for each color in computer_cipher_sequence
          #if color matches computer_cipher_sequence.color
            #feedback + red
          #else if color matches.any computer_cipher_sequence BUT NOT INDEX
            #feedback + white
          #else if color doesn't match.any? or index or computer_cipher_sequence
            #feedback + blank

    end #end play

    def player_has_won?
      computer_cipher_sequence == player_guess ? true : false
    end #end player_has_won?

    def player_guess_sequence
      puts "#{player.name} pick 4 choices by typing from the selections below."
      COLOR_CHOICES.each { |color| puts color }
      puts "** type your choices like so - 'Red' **"

      player_guesses = []
      4.times { |i| puts "Guess # #{i}" player_guess.push(gets.chomp.downcase) }
      player_guess_color_conversion(player_guesses)

    end #player_guess_sequence

    def player_guess_color_conversion(guesses)

    end #end player_guess_color_conversion

    def feedback

    end #end feedback

  end

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
