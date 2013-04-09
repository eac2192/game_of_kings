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

    to_string:  () ->
        rep = ""
        for row, row_num in @spaces
            for element, colum_num in row
                if element == null
                    rep += "| X |"
                else
                    rep += "| " + element.to_string() + " |"
            rep += '\n'
        rep
