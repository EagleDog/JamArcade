# Encoding: UTF-8
#                                             #
#               JAM ARCADE                    #
#           2021 Gosu Game Jam                #
#                                             #
#                                             #

# require "gosu"
require_relative 'chingu/chingu'
require_relative 'chingu/resurrection'
require_relative 'master'
require_relative 'calm/loader'
require_relative 'butterfly/loader'
require_relative 'peeve/loader'
require_relative 'boxes/loader'
require_relative 'relax/loader'
require_relative 'bricks/loader'
require_relative 'penguin/loader'
require_relative 'scheduler/loader'

module Colors   # colors
  White = Gosu::Color::WHITE
  Black = Gosu::Color::BLACK
  Dark_Orange = Gosu::Color.new(0xFFCC3300)
  Blue_Laser = Gosu::Color.new(0xFF86EFFF)
end


class Arcade < Chingu::Window
  # trait :debug => true

  def initialize
    super(1100, 700, true) #640, 480
    self.caption = "          JAM ARCADE"
    self.input = { :esc => :pop,  # global controls
                   :p => Pause,   # Pause not working
                   :g => :gamestate_logger,
                   :r => Resurrection,
                   :z => Calm,
                   :v => ButterflySurfer,
                   :x => Peeve,
                   :b => Boxes,
                   :c => :relax,
                   :n => Scheduler,
                   :m => BricksGame,
                   :k => PenguinGame
               }
#    retrofy
  end

  def setup
#    push_game_state(MasterMenu)
    push_game_state(Resurrection)
  end

  def gamestate_logger
    puts(current_game_state)
  end

  def pop
    if current_game_state.to_s != 'MasterMenu'
      push_game_state(MasterMenu)
    else
      exit
    end
  end

  def relax
    push_game_state(Opening1)
  end

  def pause_game
    if current_game_state.to_s != Pause
      push_game_state(Pause)
    end
  end
end

#
#  PAUSE GAMESTATE
#    press 'P' to pause (currently doesn't work)
class Pause <  Chingu::GameState
  def setup #(options = {})
#    super
    @title = Chingu::Text.create(:text=>"PAUSED (press 'P' to un-pause)", :y=>110, :size=>30, :color => Colors::White, :zorder=>1000 )
    @title.x = 400 - @title.width/2
    @title2 = Chingu::Text.create(:text=>"PAUSED (press 'P' to un-pause)", :y=>110 + 3, :size=>30, :color => Colors::Black, :zorder=>900 )
    @title2.x = 400 - @title.width/2 + 3
    self.input = { :p => :un_pause, :r => :reset, :n => :next }
#    $music.pause
  end
  def un_pause
#    $music.play
    pop_game_state(:setup => false)    # Return the previous game state, dont call setup()
  end
  def reset  # pressing 'r' resets the gamestate
    pop_game_state(:setup => true)
  end
  def next
    push_game_state(Introduction)
  end
  def draw
    previous_game_state.draw    # Draw prev game state onto screen (in this case our level)
    super                       # Draw game objects in current game state, this includes Chingu::Texts
  end
end


Arcade.new.show # if __FILE__ == $0
