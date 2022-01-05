module MasterMind
  COLOR_CHOICES = [['red'], ['green'], ['blue'], ['magenta'], ['cyan'], ['white']].freeze
  turns = 12

  class String
    def bg_red
      "\e[41m#{self}\e[0m"
    end

    def bg_green
      "\e[42m#{self}\e[0m"
    end

    def bg_blue
      "\e[44m#{self}\e[0m"
    end

    def bg_magenta
      "\e[45m#{self}\e[0m"
    end

    def bg_cyan
      "\e[46m#{self}\e[0m"
    end

    def bg_white
      "\e[47m#{self}\e[0m"
    end
  end

  class Game
    def initialize(string_colors)
      temp_color_choice = []
      temp_color_choice[0] = '  '.bg_red
      temp_color_choice[1] = '  '.bg_green
      temp_color_choice[2] = '  '.bg_blue
      temp_color_choice[3] = '  '.bg_magenta
      temp_color_choice[4] = '  '.bg_cyan
      temp_color_choice[5] = '  '.bg_white
      all_color_choices = temp_color_choice

      computer_cipher_sequence = []
      4.times { computer_cipher_sequence.push(temp_color_choice.delete_at(rand(temp_color_choice.length))) }
    end

    def play
      loop do
        new_player.guesses = []
        puts "#{new_player.name} pick 4 choices one at a time by typing from the selections below."
        COLOR_CHOICES.each { |color| puts color }
        puts "** type your choice like so - 'Red' **"
        player_guess_sequence

        if player_has_won?
          puts "#{new_player.name} won! Way to go!"
          puts new_player.guesses
          return
        elsif turns.zero?
          puts 'Out of turns! You lost.'
          return
        else
          turns -= 1
          puts "#{turns} turn(s) left"
        end
      end

      feedback(new_player.guesses)
    end

    def feedback(player_guess)
      displayed_feedback = []
      # for each color in computer_cipher_sequence
      computer_cipher_sequence.each_with_index do |color, index|
        player_guess.each do |guess|

          if guess == color
            displayed_feedback.push('  '.bg_red)
          elsif computer_cipher_sequence.any? { |x| x == guess } && guess != color
            displayed_feedback.push('  '.bg_white)
          else
            displayed_feedback.push('  ')
          end
        end
      end

      puts "#{displayed_feedback.join('')}"
    end

    def player_has_won?
      computer_cipher_sequence == new_player.guesses
    end

    def player_guess_sequence
      loop do
        guess = gets.chomp.downcase

        if COLOR_CHOICES.any? == guess
          new_player.guesses.push(guess)
        else
          puts 'Not one of the choices, try again'
        end

        player_guess_text_to_color(new_player.guesses)

        if player_guess.length == 4
          puts "Your guesses #{new_player.guesses.join('')}"
          return
        end
      end
    end

    def player_guess_text_to_color(guesses)
      guesses.map! do |text_color|
        case text_color
        when 'red'
          guesses[text_color] = '  '.bg_red
        when 'green'
          guesses[text_color] = '  '.bg_green
        when 'blue'
          guesses[text_color] = '  '.bg_blue
        when 'magenta'
          guesses[text_color] = '  '.bg_magenta
        when 'cyan'
          guesses[text_color] = '  '.bg_cyan
        when 'white'
          guesses[text_color] = '  '.bg_white
        end
      end
    end
  end

  class Player
    attr_reader :name
    attr_accessor :guesses

    def initialize(name, guesses)
      @name = name
      @guesses = guesses
    end
  end

  class ComputerPlayer
  end
end

include MasterMind

puts 'Welcome to Master Mind'
puts 'What is your name?'
player_name = gets.chomp

new_player = Player.new(player_name, [])

instance = String.new
Game.new(instance).play
