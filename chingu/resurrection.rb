#
#
#      CHINGU RESURRECTION
#
#

RBPTH = "chingu/rebirth_assets/"

class Resurrection < Chingu::GameState
  trait :timer

  def setup
    @graveyard = Gosu::Image.new("" + RBPTH + "graveyard.png")
    @tombstone = Gosu::Image.new("" + RBPTH + "tombstone.png")
    @empty_grave = Gosu::Image.new("" + RBPTH + "empty_grave.png")

#    @cracks = [@crack1, @crack2, @crack3]
#    @chunks = [@chunk1, @chunk2, @chunk3, @chunk4, @chunk5]

    after(500) { rupture_earth }
    after(500) { birth_gem }
    after(20000) { push_master_menu }
  end

  def rupture_earth
    @rift1 = Rift1.create(:x => 500, :y => 500, :zorder => Z::PLAYER)
    @rift1.tremble
    after(2000) {
      @rift2 = Rift2.create(:x => 500, :y => 500, :zorder => Z::PLAYER)
      @rift2.tremble
      @rift3 = Rift3.create(:x => 480, :y => 500, :zorder => Z::PLAYER)
      @rift3.tremble  }
  end

  def birth_gem
    @chunk1 = Chunk1.create(:x => 400, :y => 600, :angle => 0, :factor_x => 1,  :zorder => Z::PLAYER + 1)
    @chunk2 = Chunk2.create(:x => 450, :y => 450, :angle => 0, :factor_x => 1,  :zorder => Z::PLAYER + 1)
    @chunk3 = Chunk3.create(:x => 560, :y => 440, :angle => 200, :factor_x => -1, :zorder => Z::PLAYER + 1)
    @chunk4 = Chunk4.create(:x => 580, :y => 560, :angle => 250, :factor_x => 1,  :zorder => Z::PLAYER + 1)
    @chunk5 = Chunk5.create(:x => 480, :y => 540, :angle => -45, :factor_x => -1, :zorder => Z::PLAYER + 1)
    @left_chunks = [@chunk1, @chunk2, @chunk5]
    @right_chunks = [@chunk3, @chunk4 ]

    shake_chunks

    after(900) { @gem = ChinguGem.create(:x => 490, :y => 500, :factor => 0.7, :zorder => Z::PLAYER) }

    after(1100) { shake_chunks; @gem.grow; @gem.move }

    after(2000) { make_chunks; fling_chunks; }

  end

  def fling_chunks
    @left_chunks.each do |chunk| chunk.fling(1) end
    @right_chunks.each do |chunk| chunk.fling(-1) end
  end

  def shake_chunks
    @left_chunks.each do |chunk| chunk.shake(1) end
    @right_chunks.each do |chunk| chunk.shake(-1) end
  end

  def make_chunks
    3.times { @left_chunks.push(Chunk2.create(:x => @gem.x, :y => @gem.y)) }
    2.times { @left_chunks.push(Chunk1.create(:x => @gem.x, :y => @gem.y)) }
    4.times { @right_chunks.push(Chunk5.create(:x => @gem.x, :y => @gem.y)) }
  end

  def push_master_menu
    push_game_state(MasterMenu)
  end

  def draw
    super
    @graveyard.draw(0, 0, Z::BACKGROUND)
    @tombstone.draw(380, 80, Z::BACKGROUND + 1)
    @empty_grave.draw(380, 400, Z::BACKGROUND + 1)
  end

end


class Rift < Chingu::GameObject
  trait :timer
  def tremble
    after(200) {
      after(50) { self.factor = 1.1 }
      after(400) { self.factor = 0.9 }
      after(480) { self.factor = 1.1 }
      after(900) { self.factor = 1.2 }
      after(950) { self.factor = 1.0 }
      after(1050) { self.factor = 1.2 }
      after(1350) { self.factor = 1.1 }
      after(1400) { self.factor = 1.3 }
      after(1450) { self.factor = 1.0 }
      after(1500) { self.factor = 1.4 }
    }
  end
end

class Rift1 < Rift; def setup; @image = Gosu::Image.new(""+RBPTH+"crack1.png"); end; end
class Rift2 < Rift; def setup; @image = Gosu::Image.new(""+RBPTH+"crack2.png"); end; end
class Rift3 < Rift; def setup; @image = Gosu::Image.new(""+RBPTH+"crack3.png"); end; end

class Chunk < Chingu::GameObject
  trait :timer
  def setup
    @color = 0xFFDDDDDD
    @velocity_x = 0
    @velocity_y = 0
  end

  def shake(dir)
    counter = 0
    3.times {
      counter += 40
      after(counter) { self.angle += 2 * dir }
      counter += 40
      after(counter) { self.angle -= 4 * dir }
    }
  end

  # def shake_right
  #   counter = 0
  #   3.times {
  #     counter += 40
  #     after(counter) { self.angle -= 2 }
  #     counter += 40
  #     after(counter) { self.angle += 4 }
  #   }
  # end

  def fling(dir)
    @velocity_x = -5 * dir
    @velocity_y = -5
  end
  # def fling_right
  #   @velocity_x = -20
  #   @velocity_y = -40
  # end

  def land
  end

  def update
    @x = @x + @velocity_x
    @y = @y + @velocity_y 
  end

#  def draw
#    super
#    @image.draw_rot(@x, @y, 20, @angle, @center_x, @center_y, 1.0, 1.0, @color)
#                   [@x, @y, @angle, @center_x, @center_y, @factor_x, @factor_y, @color.dup, @mode, @zorder]
#
#  end

end

class Chunk1 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk1.png"); end; end
class Chunk2 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk2.png"); end; end
class Chunk3 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk3.png"); end; end
class Chunk4 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk4.png"); end; end
class Chunk5 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk5.png"); end; end



class ChinguGem < Chingu::GameObject
  attr_reader :x, :y
  def setup
    @image = Gosu::Image.new(""+RBPTH + "chingu_gem.png")
    @growing = false
    @moving = false
  end

  def grow
    @growing = true
  end

  def move
    @moving = true
  end

  def update
    if @growing && @factor < 1
      self.factor += 0.005
    end
    if @moving && self.y > 250
      self.y -= 4
    end
  end

end




