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
  to_s: -> "P"

  moves: ->
    positions = [ ]
    double_move = (@is_black() and @y == 1) || (@is_white() and @y  == 7)
    positions.push([@x, @y + @color*1])
    positions.push([@x, @y + @color*2]) if double_move
    positions

class @Bishop extends Piece
  to_s: -> "B"

class @Rook extends Piece
  to_s: -> "R"

class @Knight extends Piece
  to_s: -> "H"

class @Queen extends Piece
  to_s: -> "Q"

class @King extends Piece
  to_s: -> "K"

[@Pawn, @Bishop, @Rook, @Queen, @Knight, @King].map (klass) ->
  include klass,
    is_black: -> @color == 1
    is_white: -> !@is_black
