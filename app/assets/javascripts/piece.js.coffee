class @Piece
  constructor: (@pos) ->

  get_pos: () ->
    @pos

  move: () ->
    5
 
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