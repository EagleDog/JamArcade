#
#  MASTER MENU GAMESTATE
#
class MasterMenu < Chingu::GameState
  trait :timer
  def initialize
    super
    self.input = { [:up, :w] => :go_up,
      [:down, :s] => :go_down,
      [:right, :d] => :go_fullscreen,
      [:left, :a] => :leave_fullscreen,
      [:enter, :return] => :choose_game }
  end

  def setup
    $window.width = 1100
    $window.height = 700
    $window.cursor = false
    $music = Gosu::Song["butterfly/sounds/space.flac"]
    $music.volume = 0.3
    $music.play(true)

    Chingu::Text.destroy_all # destroy any existing Text
    $window.caption = "          MASTER MENU"
    @click = Gosu::Sound["click.ogg"]
    @chime = Gosu::Sound["pickup_chime.ogg"]

    # @games = [ calm
    #   { text: 'Play', method: :start_game },
    #   { text: 'How To Play', method: :display_how_to_play },
    #   { text: 'Fullscreen', method: :toggle_fullscreen },
    #   { text: 'Credits', method: :display_credits },
    #   { text: 'Quit', method: :quit }
    # ]

    @games = [:calm, :peeve, :relax, :butterfly, :boxes]
    @menu_index = 0
    make_text
    after(500) { @text_exists = true
      @texts = [@text1, @text2, @text3, @text4, @text5] }
  end

  def go_up
    @click.play
    @menu_index -= 1
    @menu_index = @texts.length - 1 if @menu_index < 0
  end

  def go_down
    @click.play
    @menu_index += 1
    @menu_index = 0 if @menu_index > @texts.length - 1
  end

  def choose_game
    @chime.play
    self.send(@games[@menu_index])
    @menu_index = 0
  end

  def unhighlight_text
    @texts.each do |text| text.factor = 1 end
  end
  def highlight_text
    @texts[@menu_index].factor = 1.2
    #@texts[@menu_index].factor_y = 1.4
  end

  def update
    if @text_exists == true
      unhighlight_text
      highlight_text
    end
  end

  def calm
    push_game_state(Calm)
  end
  def peeve
    push_game_state(Peeve)
  end
  def relax
    push_game_state(Opening1)
  end
  def butterfly
    push_game_state(ButterflySurfer)
  end
  def boxes
    push_game_state(Boxes)
  end
  def penquin
  end
  def bricks
  end
  def scheduler
  end

  def go_fullscreen
    $window.fullscreen = true
  end
  def leave_fullscreen
    $window.fullscreen = false
  end

  def make_text
    after(50) {
      @text = Chingu::Text.create("Master Menu",
        :y => 125, :font => "GeosansLight", :size => 70,
        :color => Colors::White, :zorder => 10)
      @text.x = 1100/2 - @text.width/2 # center text
    }
    after(100) {
      @text1 = Chingu::Text.create("Keep Calm and Balance",
        :y => 200, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text1.x = 200 #1100/2 - @text2.width/2 # center text
    }
    after(150) {
      @text2 = Chingu::Text.create("Pet Peeve",
        :y => 275, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text2.x = 200 #1100/2 - @text2.width/2 # center text
    }
    after(200) {
      @text3 = Chingu::Text.create("Relax",
        :y => 350, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text3.x = 200 #1100/2 - @text2.width/2 # center text
    }
    after(250) {
      @text4 = Chingu::Text.create("Butterfly Surfer",
        :y => 425, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text4.x = 200 #1100/2 - @text2.width/2 # center text
    }
    after(300) {
      @text5 = Chingu::Text.create("Boxes",
        :y => 500, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text5.x = 200 #1100/2 - @text2.width/2 # center text
    }
  end

end
