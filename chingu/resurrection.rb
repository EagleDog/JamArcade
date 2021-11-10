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
    @graveyard = Gosu::Image.new("" + RBPTH + "graveyard.png")
    @tombstone = Gosu::Image.new("" + RBPTH + "tombstone.png")
    @empty_grave = Gosu::Image.new("" + RBPTH + "empty_grave.png")

    @grave_hole = false

#    @cracks = [@crack1, @crack2, @crack3]
#    @chunks = [@chunk1, @chunk2, @chunk3, @chunk4, @chunk5]

    after(500) { rupture_earth }
    after(3500) { birth_gem }
    after(20000) { push_master_menu }
  end

  def rupture_earth
    @rift1 = Rift1.create(:x => 550, :y => 500, :zorder => Z::PLAYER)
    after(300) { @rift1.tremble }
    after(1800) {
      @rift2 = Rift2.create(:x => 550, :y => 500, :zorder => Z::PLAYER)
      @rift2.tremble   }
    after(2000) {
      @rift3 = Rift3.create(:x => 530, :y => 500, :zorder => Z::PLAYER)
      @rift3.tremble
      @rifts = [@rift1, @rift2, @rift3]   }
  end

  def birth_gem
    @chunk1 = Chunk1.create(:x => 450, :y => 600, :angle => 0, :factor_x => 1,  :zorder => Z::PLAYER + 3)
    @chunk2 = Chunk2.create(:x => 500, :y => 450, :angle => 0, :factor_x => 1,  :zorder => Z::PLAYER + 3)
    @chunk3 = Chunk3.create(:x => 610, :y => 440, :angle => 200, :factor_x => -1, :zorder => Z::PLAYER + 3)
    @chunk4 = Chunk4.create(:x => 630, :y => 560, :angle => 250, :factor_x => 1,  :zorder => Z::PLAYER + 3)
    @chunk5 = Chunk5.create(:x => 530, :y => 540, :angle => -45, :factor_x => -1, :zorder => Z::PLAYER + 3)
    @left_chunks = [@chunk1, @chunk2, @chunk5]
    @right_chunks = [@chunk3, @chunk4 ]

    shake_chunks

    after(1100) { shake_chunks }

    after(1400) { create_gem; make_chunks
                  @gem.grow; @gem.move; @grave_hole = true;
                  fling_chunks; destroy_rifts }

#    after(1800) { @gem.grow; @gem.move }

#    after(2000) { fling_chunks; @grave_hole = true; destroy_rifts }


  end

  def destroy_rifts
    @rifts.each do |rift| rift.destroy end
  end

  def create_gem
    @gem = ChinguGem.create(:x => 540, :y => 500, :factor => 0.6, :zorder => Z::PLAYER + 1)
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
    3.times { @left_chunks.push(Chunk2.create(:x => @gem.x - rand(20), :y => @gem.y - rand(20), :zorder => Z::PLAYER + 2)) }
    4.times { @left_chunks.push(Chunk1.create(:x => @gem.x - rand(20), :y => @gem.y - rand(20), :zorder => Z::PLAYER + 2)) }
    4.times { @right_chunks.push(Chunk5.create(:x => @gem.x - rand(20), :y => @gem.y - rand(20), :zorder => Z::PLAYER + 2)) }
    3.times { @left_chunks.push(Chunk3.create(:x => @gem.x - rand(20), :y => @gem.y - rand(20), :zorder => Z::PLAYER + 2)) }
    3.times { @right_chunks.push(Chunk1.create(:x => @gem.x - rand(20), :y => @gem.y - rand(20), :zorder => Z::PLAYER + 2)) }
    2.times { @right_chunks.push(Chunk4.create(:x => @gem.x - rand(20), :y => @gem.y - rand(20), :zorder => Z::PLAYER + 2)) }
    4.times { @right_chunks.push(Chunk5.create(:x => @gem.x - rand(20), :y => @gem.y - rand(20), :zorder => Z::PLAYER + 2)) }
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

