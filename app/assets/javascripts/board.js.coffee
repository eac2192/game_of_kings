class @Board
    constructor: ->
      @spaces = [ ]
      for i in [0..7] by 1
        @spaces[i] = []
        color = if i < 2 then 1 else -1
        for j in [0..7] by 1
          if i == 1 or i == 6
            @spaces[i][j] = new Pawn(j, i, color)
          else
            @spaces[i][j] = null

    piece_at: (row, col) ->
        @spaces[row][col]

    to_s: ->
      '\n' + @spaces.map( (row) ->
        row.map( (el) ->
          if el == null then " " else el.to_s()
        ).join(' | ')
      ).join('\n')

    children: (color) ->
      boards = [ ]
      for row in @spaces
        for p in row
          if p isnt null and p.color is color
            current_mvs = p.moves()
            for move in current_mvs
              unless @spaces[move[1]][move[0]]
                b = new Board
                b.move(from: [p.x, p.y], to: move)
                boards.push b
      boards

    move: (hash) ->
      from_x = hash['from'][0]
      from_y = hash['from'][1]
      to_x = hash['to'][0]
      to_y = hash['to'][1]
      p = @spaces[from_y][from_x]
      @spaces[from_y][from_x] = null
      @spaces[to_y][to_x] = p
