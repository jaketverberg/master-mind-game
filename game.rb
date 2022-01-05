module MasterMind
  COLOR_CHOICES = %w[red green blue magenta cyan white].freeze

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

  def black
    "\e[30m#{self}\e[0m"
  end

  class Game
    def initialize(player)
      @player = player
      @turns = 12
      @computer_cipher_sequence = []
      choose_sequence(@computer_cipher_sequence)
      temp_color_choice = ['  '.bg_red,
                           '  '.bg_green,
                           '  '.bg_blue,
                           '  '.bg_magenta,
                           '  '.bg_cyan,
                           '  '.bg_white]

      4.times { @computer_cipher_sequence.push(temp_color_choice.delete_at(rand(temp_color_choice.length))) }
    end
    attr_reader :player

    def choose_sequence(cipher)
      4.time { cipher.push(temp_color_choice.delete_at(rand(temp_color_choice.length))) }
    end

    def play
      puts "You have #{@turns} turns to guess the cipher"
      loop do
        player.guesses = []
        puts "#{player.name} pick 4 choices one at a time by typing from the selections below."
        puts ['red'.bg_red,
              'green'.bg_green,
              'blue'.bg_blue,
              'magenta'.bg_magenta,
              'cyan'.bg_cyan,
              'white'.bg_white.black].join(' ')
        puts "** type your choice like so - 'Red' **"
        player_guess_sequence

        if player_has_won?
          puts "You guessed the cipher #{player.name}! Way to go!"
          puts player.guesses.join
          break
        elsif @turns.zero?
          puts 'Out of turns! You lost.'
          break
        else
          @turns -= 1
          puts "Solid attempt. You have #{@turns} turn(s) left"
          feedback(player.guesses)
        end
      end
    end

    def feedback(player_guess)
      displayed_feedback = [' 1 ', ' 2 ', ' 3 ', ' 4 ']
      @computer_cipher_sequence.each_with_index do |color, index|
        if player_guess[index] == color
          displayed_feedback[index] = displayed_feedback[index].bg_red
          next
        elsif @computer_cipher_sequence.any? { |cipher_color| cipher_color == player_guess[index] }
          displayed_feedback[index] = displayed_feedback[index].bg_white.black
          next
        end
      end
      puts "Your Guesses: #{player.guesses.join}"
      puts "Feedback: #{displayed_feedback.join}"
    end

    def player_has_won?
      @computer_cipher_sequence == player.guesses
    end

    def player_guess_text_to_color(guess)
      case guess
      when 'red'
        '  '.bg_red
      when 'green'
        '  '.bg_green
      when 'blue'
        '  '.bg_blue
      when 'magenta'
        '  '.bg_magenta
      when 'cyan'
        '  '.bg_cyan
      when 'white'
        '  '.bg_white
      end
    end
  end

  class Player
    attr_reader :name
    attr_accessor :guesses

    def initialize(name)
      @name = name
      @guesses = []
    end
  end

  def player_guess_sequence
    loop do
      guess = gets.chomp.downcase

      if COLOR_CHOICES.any?(guess)
        player.guesses.push(player_guess_text_to_color(guess))
      else
        puts 'Not one of the choices, try again'
      end

      if player.guesses.length == 4
        return
      end
    end
  end

  class ComputerPlayer
  end
end

include MasterMind

puts 'Welcome to Master Mind'
puts 'What is your name?'
player_name = gets.chomp

player = Player.new(player_name)

Game.new(player).play
