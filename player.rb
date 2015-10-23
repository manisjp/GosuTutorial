require "gosu"
require_relative 'z_order'
require_relative 'star'

class Player

	attr_reader :score, :health

	TURN_INCREMENT = 4.5
	ACCELERATION = 0.5
	COLLISION_DISTANCE = 35

	def initialize
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
		@health = 100
		@image = Gosu::Image.new("media/starfighter.bmp")
		@beep = Gosu::Sample.new("media/beep.wav")
	end

	def warp x, y
		@x, @y = x, y		
	end

	def turn_left
		@angle -= TURN_INCREMENT 
	end

	def turn_right
		@angle += TURN_INCREMENT
	end

	def accelerate
		@vel_x += Gosu::offset_x(@angle, ACCELERATION)
		@vel_y += Gosu::offset_y(@angle, ACCELERATION)
	end

	def move
		@x += @vel_x
		@y += @vel_y

		@x %= 640
		@y %= 480

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def draw
		@image.draw_rot(@x, @y, ZOrder::PLAYER, @angle)
	end

	def score
		@score
	end

	def health
		@health
	end

	def collect_stars stars
		if stars.reject! { |star| colliding?(star) }
			@score += 1
			@beep.play
		end
	end

	def bombed bombs
		if bombs.reject! { |bomb| colliding?(bomb) }
			@health -= 10
		end
	end

	def death?
		@health <= 1
	end

	private
		def colliding? object
			Gosu::distance(@x, @y, object.x, object.y) < COLLISION_DISTANCE
		end

end