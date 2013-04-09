class @Piece
	constructor: (@pos) ->

	get_pos: () ->
		@pos

	move: () ->
		5

class @Pawn extends Piece
	move: () ->
		@pos = @pos + 1

