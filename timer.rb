require "gosu"
require_relative 'player'
require_relative 'z_order'

class Timer

	attr_reader :time_left

	def initialize player
		@time_left = 60
		@player = player
	end	

	def print_out
		if @time_left > 1 && !@player.death?
			@time_left -= 0.01
			"Time Left: #{@time_left.truncate}"
		else
			"Game OVER"
		end

	end

	def game_over?
		@time_left <= 1
	end

end