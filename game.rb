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
    def initialize(player, computer)
      @player = player
      @computer_player = computer
      @turns = 12
      @player_mastermind = false
      @computer_cipher_sequence = []
      @human_cipher_sequence = []
      @temp_color_choice = ['  '.bg_red,
                           '  '.bg_green,
                           '  '.bg_blue,
                           '  '.bg_magenta,
                           '  '.bg_cyan,
                           '  '.bg_white]
      loop do
        puts 'Do you want to play as the Mastermind? Y/N'
        answer = gets.chomp.upcase
        if answer == 'Y'
          @player_mastermind = true
          break
        elsif answer == 'N'
          @player_mastermind = false
          break
        else
          puts 'Not an answer, please type either "Y" or "N"'
        end
      end

      computer_player.comp_choose_sequence(@temp_color_choice, @computer_cipher_sequence)
    end
    attr_reader :player, :computer_player

    def play
      unless @player_mastermind
        puts "You have #{@turns} turns to guess the cipher."

        loop do
          player.guesses = []
          puts "#{player.name} pick 4 choices one at a time by typing from the selections below.
          There are no duplicate colors."
          puts ['red'.bg_red,
                'green'.bg_green,
                'blue'.bg_blue,
                'magenta'.bg_magenta,
                'cyan'.bg_cyan,
                'white'.bg_white.black].join(' ')
          puts "** type your choice one at a time like so - 'red' + enter **"
          player_guess_sequence

          if @turns.zero?
            puts 'Out of turns! You lost.'
            break
          elsif player_has_won?
            puts "You guessed the cipher #{player.name}! Way to go!"
            puts player.guesses.join
            break
          else
            @turns -= 1
            puts "Solid attempt. You have #{@turns} turn(s) left"
            feedback(player.guesses)
          end
        end
      else
        puts 'What cipher do you choose?'
        puts "#{player.name} pick 4 choices one at a time by typing from the selections below."
        puts 'Duplicates are allowed'
        puts ['red'.bg_red,
              'green'.bg_green,
              'blue'.bg_blue,
              'magenta'.bg_magenta,
              'cyan'.bg_cyan,
              'white'.bg_white.black].join(' ')
        puts "** type your choice one at a time like so - 'red' + enter **"
        player_cipher_sequence
        computer_player.comp_choose_sequence(@temp_color_choice, computer_player.guesses)

        loop do
          if @turns.zero?
            puts "#{player.name} won! Computer couldn't guess the cipher"
            break
          elsif computer_player_has_won?
            puts 'Computer guessed the cipher! You lost'
            puts computer_player.guesses.join
            break
          else
            @turns -= 1
            puts "Computer guessed #{computer_player.guesses.join}"
            puts "Computer has #{@turns} attempt(s) left"
            computer_player.guesses.each_with_index do |guess, index|
              if guess == player.cipher[index]
                next
              else
                computer_player.guesses[index] = new_color_picker(computer_player.guesses[index])
              end
            end
          end
        end
      end
    end

    def new_color_picker(change_me)
      choices = @temp_color_choice.clone
      choices.delete(change_me)
      choices.sample
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

    def computer_player_has_won?
      player.cipher == computer_player.guesses
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
    attr_accessor :guesses, :cipher

    def initialize(name)
      @name = name
      @guesses = []
      @cipher = []
    end
  end

  def player_cipher_sequence
    loop do
      cipher = gets.chomp.downcase

      if COLOR_CHOICES.any?(cipher)
        player.cipher.push(player_guess_text_to_color(cipher))
      else
        puts 'Not one of the choices, try again'
      end

      if player.cipher.length == 4
        puts "#{player.name}'s cipher: #{player.cipher.join}"
        return
      end
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
    attr_accessor :guesses

    def initialize
      @guesses = []
    end

    def comp_choose_sequence(colors, cipher)
      editable_colors = colors.clone
      4.times { cipher.push(editable_colors.delete_at(rand(editable_colors.length))) }
    end

    def computer_guess_sequence
      self.guesses = comp_choose_sequence(@temp_color_choice, @guesses)
    end
  end
end

include MasterMind

puts 'Welcome to Master Mind'
puts 'What is your name?'
player_name = gets.chomp

human = Player.new(player_name)
comp = ComputerPlayer.new

Game.new(human, comp).play
