class @Board
    constructor: () ->
        @spaces = [[new Rook, new Knight, new Bishop, new Queen, new King, new Bishop, new Knight, new Rook],
                   [new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn],
                   [null, null, null, null, null, null, null, null],
                   [null, null, null, null, null, null, null, null],
                   [null, null, null, null, null, null, null, null],
                   [null, null, null, null, null, null, null, null],
                   [new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn, new Pawn],
                   [new Rook, new Knight, new Bishop, new King, new Queen, new Bishop, new Knight, new Rook]]

    piece_at: (row, col) ->
        @spaces[row][col]

    is_white: (row, col) ->
        white = null;
        if row % 2 == 0
            if col % 2 == 0
                white = 1
            else 
                white = 0
        else
            if col % 2 == 0
                white = 0
            else 
                white = 1


    to_string:  () ->
        rep = ""
        for row, row_num in @spaces
            for element, colum_num in row
                if element == null
                    if @is_white(row_num, colum_num)
                        rep += "| X |"
                    else
                        rep += "|#X#|"
                else
<<<<<<< HEAD
                    if @is_white(row_num, colum_num)
                        rep += "| " + element.to_string() + " |"
                    else
                        rep += "|#" + element.to_string() + "#|"
            rep += '\n---------------------------\n'
        rep
=======
                    rep += "| " + element.to_string() + " |"
            rep += '\n'
        rep
>>>>>>> 0537719c542d541267e4194d81349c1fdb1a97a9
