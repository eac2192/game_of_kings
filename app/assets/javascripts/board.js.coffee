class @Board
    constructor: () ->
        @spaces = [[null, null, null, null, null, null, null, null],
                   [new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn],
                   [null, null, null, null, null, null, null, null],
                   [null, null, null, null, null, null, null, null],
                   [null, null, null, null, null, null, null, null],
                   [null, null, null, null, null, null, null, null],
                   [new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn],
                   [null, null, null, null, null, null, null, null]]

        piece_at: (row, col) ->
            @spaces[row][col]