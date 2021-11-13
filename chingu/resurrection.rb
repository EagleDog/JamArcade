#
#
#      CHINGU RESURRECTION
#
#

RBPTH = "chingu/rebirth_assets/"

require_relative "./resurrection_objects"

class Resurrection < Chingu::GameState
  trait :timer

  def setup
    self.input = { [:enter, :return, :space] => MasterMenu }

    @graveyard = Gosu::Image.new("" + RBPTH + "graveyard.png")
    @tombstone = Gosu::Image.new("" + RBPTH + "tombstone.png")
    @empty_grave = Gosu::Image.new("" + RBPTH + "empty_grave.png")

    @left_chunks = []
    @right_chunks = []

    @grave_hole = false
    @gem_spot = [540, 530]
    @chunk_y = 550
    @rand_range = 110
    @zord = 10

    @gem

#    make_chunks
#    make_more_chunks
#    shake_chunks

    after(800) { rifting }
#    after(4200) { rupture_earth }
    after(6200) { rupture_earth }
    after(10200) { explode_earth }
    after(14400) { push_master_menu }
  end

  def rifting
    @rift1 = Rift1.create(:x => 530, :y => 530, :zorder => @zord)
    after(300) { @rift1.tremble1 }

    after(3000) {
      after(400) { @rift1.destroy! }
      @rift11 = Rift1.create(:x => 530, :y => 530, :zorder => @zord)
      @rift2 = Rift2.create(:x => 550, :y => 540, :factor => 0.9, :zorder => @zord)
      @rift3 = Rift3.create(:x => 530, :y => 540, :zorder => @zord)
      @rift11.tremble2
      @rift2.tremble2
      @rift3.tremble2
    }
  end

  def rupture_earth
    make_chunks; shake_chunks; severe_tremble
#    make_more_chunks
#    @rift2.destroy!
#    @rift3.tremble
#    make_more_chunks
    after(1200) { create_gem; shake_gem; make_more_chunks; shake_chunks; severe_tremble  }
    after(2000) { shake_gem; shake_chunks; severe_tremble }
  end

  def explode_earth
#    create_gem
    @grave_hole = true
#    make_more_chunks
    fling_chunks
    destroy_rifts              # DESTROY RIFTS
    @gem.grow
    @gem.move
  end

  def severe_tremble
    @rift11.tremble3
    @rift2.tremble3
    @rift3.tremble3
  end

  def destroy_rifts
    @rift2.destroy!
    @rift3.destroy!
    @rift11.destroy!
  end

  def create_gem
    @gem = ChinguGem.create(:x => @gem_spot[0], :y => @gem_spot[1], :factor => 0.5, :zorder => @zord + 1)
  end

  def shake_gem
    @gem.shake
  end

  def shake_chunks
    @left_chunks.each do |chunk| chunk.shake(1) end
    @right_chunks.each do |chunk| chunk.shake(-1) end
  end

  def fling_chunks
    @left_chunks.each do |chunk| chunk.fling(1) end
    @right_chunks.each do |chunk| chunk.fling(-1) end
  end

  def make_chunks
    @left_chunks.push(Chunk1.create(:x => 450, :y => 500, :angle => -45, :factor_x => 1,  :zorder => @zord + 3) )
    @left_chunks.push(Chunk2.create(:x => 490, :y => 430, :angle => 0, :factor_x => 1,  :zorder => @zord + 3) )
    @right_chunks.push(Chunk3.create(:x => 590, :y => 470, :angle => 210, :factor_x => -1, :zorder => @zord + 4) )
    @right_chunks.push(Chunk4.create(:x => 630, :y => 590, :angle => 250, :factor_x => 1,  :zorder => @zord + 3) )
    @left_chunks.push(Chunk5.create(:x => 530, :y => 550, :angle => 80, :factor_x => -1, :zorder => @zord + 3) )
  end

  def make_more_chunks
#    4.times { @left_chunks.push(Chunk1.create(:x => @gem_spot[0] - rand(@rand_range), :y => @chunk_y - @rand_range + 1.8*rand(@rand_range), :angle => rand(360), :zorder => @zord + 2)) }
    4.times { @left_chunks.push(Chunk2.create(:x => @gem_spot[0] - 20 - rand(@rand_range), :y => @chunk_y - @rand_range + 1.8*rand(@rand_range), :angle => rand(360), :zorder => @zord + 2)) }
    5.times { @left_chunks.push(Chunk4.create(:x => @gem_spot[0] - 20 - rand(@rand_range), :y => @chunk_y - @rand_range + 1.8*rand(@rand_range), :angle => rand(360), :zorder => @zord + 2)) }

    2.times { @right_chunks.push(Chunk1.create(:x => @gem_spot[0] + 20 + rand(@rand_range), :y => @chunk_y - @rand_range + 1.8*rand(@rand_range), :angle => rand(360), :zorder => @zord + 2)) }
    5.times { @right_chunks.push(Chunk2.create(:x => @gem_spot[0] + 20 + rand(@rand_range), :y => @chunk_y - @rand_range + 1.8*rand(@rand_range), :angle => rand(360), :zorder => @zord + 2)) }
    4.times { @right_chunks.push(Chunk4.create(:x => @gem_spot[0] + 20 + rand(@rand_range), :y => @chunk_y - @rand_range + 1.8*rand(@rand_range), :angle => rand(360), :zorder => @zord + 2)) }
#    1.times { @left_chunks.push(Chunk5.create(:x => @gem_spot[0] + rand(@rand_range), :y => @chunk_y - @rand_range + 1.8*rand(@rand_range), :angle => rand(360), :zorder => @zord + 2)) }
  end

  def push_master_menu
    push_game_state(MasterMenu)
  end

  def draw
    super
    @graveyard.draw(0, 0, Z::BACKGROUND)
    @tombstone.draw(380, 80, Z::BACKGROUND + 1)
    if @grave_hole
      @empty_grave.draw(360, 400, Z::BACKGROUND + 1)
    end
  end

end

