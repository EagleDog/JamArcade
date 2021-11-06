# Encoding: UTF-8
#                                             #
#               JAM ARCADE                    #
#           2021 Gosu Game Jam                #
#                                             #
#                                             #

# require "gosu"
require_relative 'chingu/chingu'
require_relative 'master/master'
require_relative 'calm/loader'
require_relative 'peeve/loader'
require_relative 'relax/loader'

module Colors   # colors
  White = Gosu::Color::WHITE
  Black = Gosu::Color::BLACK
  Dark_Orange = Gosu::Color.new(0xFFCC3300)
  Blue_Laser = Gosu::Color.new(0xFF86EFFF)
end


class Game < Chingu::Window
  # trait :debug => true

  def initialize
    super(1100,700,false) #640, 480
    self.caption = "          JAM ARCADE"
    self.input = { :esc => :exit,  # global controls
#                   :p => Pause,
                   :q => :pop,
                   :l => :log,
#                   :r => lambda{current_game_state.setup}
                   :z => :calm,
                   :x => :peeve,
                   :c => :relax
               }
#    retrofy
  end

  def setup
    push_game_state(MasterMenu)
  end

  def log
    puts(game_states)
  end

  def pop
    if game_states != 'MasterMenu'
      pop_game_state(:setup => true)
    else
      exit
    end
  end

  def calm
    push_game_state(Calm)
  end

  def peeve
    push_game_state(Peeve)
  end

  def relax
    push_game_state(Relax)
  end


end

Game.new.show # if __FILE__ == $0
