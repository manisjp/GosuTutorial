require "gosu"
require_relative 'player'
require_relative 'z_order'

class GameWindow < Gosu::Window

	def initialize
		super 640, 480
		self.caption = "Gosu Tutorial Game"	

		@background_image = Gosu::Image.new("media/space.png",
																				:tileable => true)
		@player = Player.new
		@player.warp(width/2.0, height/2.0)
	end

	def update
		@player.turn_left if Gosu::button_down? Gosu::KbLeft
		@player.turn_right if Gosu::button_down? Gosu::KbRight
		@player.accelerate if Gosu::button_down? Gosu::KbUp

		@player.move
	end

	def draw
		@player.draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
	end

	def button_down id
		close if id == Gosu::KbEscape
	end

end

window = GameWindow.new
window.show