class @Piece
  # color E [1, -1] for [black white]
  constructor: (x, y, color) ->
    @y = y
    @x = x
    @color = color

extend = (obj, mixin) ->
  obj[name] = method for name, method of mixin
  obj

include = (klass, mixin) ->
  extend klass.prototype, mixin

class @Pawn extends Piece
  moves: () ->
    positions = [ ]
    double_move = (@is_black() and @y == 1) || (@is_white() and @y  == 7)

    positions.push([@x, @y + 1])
    positions.push([@x, @y + 2]) if double_move
    positions

  to_s: -> "♟"

class @Bishop extends Piece
  to_s: -> "♝"

class @Rook extends Piece
  to_s: -> "♜"

class @Knight extends Piece
  to_s: -> "♞"

class @Queen extends Piece
  to_s: -> "♛"

class @King extends Piece
  to_s: -> "♚"

[@Pawn, @Bishop, @Rook, @Queen, @Knight, @King].map (klass) ->
  include klass,
    is_black: -> @color == 1
    is_white: -> !@is_black
