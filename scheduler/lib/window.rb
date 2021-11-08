class Scheduler < Chingu::GameState
  class SchedulerGame
  #  class Window < CyberarmEngine::Window
    class Window < CyberarmEngine::GuiState
      def setup
        push_state(SchedulerGame::States::MainMenu)
        # push_state(SchedulerGame::States::GameLost)
        # push_state(SchedulerGame::States::GameWon)
        # push_state(SchedulerGame::States::Game)

        $window.caption = "Scheduler"
      end

      def button_down(id)
        super

        close if id == Gosu::KB_ESCAPE unless @states.first.is_a?(States::MainMenu)
      end
    end
  end
end