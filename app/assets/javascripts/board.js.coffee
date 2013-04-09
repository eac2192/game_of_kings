class @Board
    constructor: ->
      @spaces = []
      for i in [0..7] by 1
        @spaces[i] = []
        for j in [0..7] by 1
          if i == 1 or i == 6
            @spaces[i][j] = new Pawn(j, i, 1)
          else
            @spaces[i][j] = null

    to_s: ->
      '\n' + @spaces.map( (row) ->
        row.map( (el) ->
          if el == null then " " else el.to_s()
        ).join(' | ')
      ).join('\n')

    children: ->
      boards = [ ]
      for row in @spaces
        for p in row
          unless p == null
            current_mvs = p.moves()
            for move in current_mvs
              b = new Board
              b.move(from: [p.x, p.y], to: move)
              boards.push b
      boards

    move: (hash) ->
      from_x = hash['from'][0]
      from_y = hash['from'][1]
      to_x   = hash['to'][0]
      to_y   = hash['to'][1]
      p = @spaces[from_y][from_x]
      @spaces[from_y][from_x] = null
      @spaces[to_y][to_x] = p
