require 'rubygems'
require 'gosu'

require_relative './lib/user_interface/game_window'

PROMPT = '> '

version = '0.5'
$window = GameWindow.new(version)
$window.show
