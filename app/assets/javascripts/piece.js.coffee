class @Piece
  constructor: (x, y) ->
    @x, @y = x, y

  move: () ->
    5

class @Pawn extends Piece
  move: () ->
    @pos = @pos + 1
