class @Board
  constructor: () ->
    @spaces = [0...20].map (x)->
      [0...20].map (y) ->
        new Piece.new()
