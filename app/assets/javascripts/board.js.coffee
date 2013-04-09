class @Board
    constructor: () ->
        @spaces = [0...8].map (x)->
            [0...8].map (y) ->
                new Piece.new()