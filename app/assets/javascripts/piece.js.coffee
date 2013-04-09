class @Piece
  # color E [1, -1] for [black white]
  constructor: (x, y, color) ->
    @y = y
    @x = x
    @color = color

  # Takes a 2d array and uses the subclasses moves function
  # to check for validity and return array of Boards
  moves: (positions) -> positions

extend = (obj, mixin) ->
  obj[name] = method for name, method of mixin
  obj

include = (klass, mixin) ->
  extend klass.prototype, mixin

class @Pawn extends Piece
  # Returns [ {x: 4, y: 5}, ...]
  moves: () ->
    positions = [ ]
    double_move = (@is_black() and @y == 1) || (@is_white() and @y  == 7)

    positions.push([@x, @y + 1])
    positions.push([@x, @y + 2]) if double_move
    super positions

class @Pawn extends Piece 
  to_string: () ->
    "P"

class @Bishop extends Piece
  to_string: () ->
    "B"

class @Rook extends Piece
  to_string: () ->
    "R"

class @Knight extends Piece
  to_string: () ->
    "H"

class @Queen extends Piece
  to_string: () ->
    "Q"

class @King extends Piece
  to_string: () ->
    "K"

include @Pawn,
  is_black: -> @color == 1
  is_white: -> !@is_black