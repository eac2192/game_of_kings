@BoardsController = ($scope) ->
  $scope._mapping =
    b:
      p: "♟"
      r: "♜"
      n: "♞"
      q: "♛"
      b: "♝"
      k: "♚"
    w:
      p: "♙"
      b: "♗"
      n: "♘"
      q: "♕"
      k: "♔"
      r: "♖"

  $scope.blackTaken = {}
  $scope.whiteTaken = {}
  $scope.currently_selected = null
  $scope.addToTaken = (x, y, color) ->
    if color == 'b'
      $scope.whiteTaken[@getPiece(x, y)] = if $scope.whiteTaken[@getPiece(x, y)] then $scope.whiteTaken[@getPiece(x, y)]+1 else 1
    else
      $scope.blackTaken[@getPiece(x, y)] = if $scope.blackTaken[@getPiece(x, y)] then $scope.blackTaken[@getPiece(x, y)]+1 else 1
  $scope.selectPiece = (x, y) ->
    p = @chess.get(x+y)
    takes = ''
    if p and p.color == @currentPlayer()
      $scope.currently_selected = x+y
    else
      selected = @chess.get($scope.currently_selected)
      letter =  if selected.type isnt 'p' then selected.type.toUpperCase() else ''
      if p 
        takes = if p.color != @currentPlayer() then 'x' else ''
        letter = if selected.type == 'p' then $scope.currently_selected[0] else letter
      console.log(letter+takes+x+y)
      if takes != '' then @addToTaken(x, y, @currentPlayer())
      console.log($scope.whiteTaken)
      @move(letter+takes+x+y)
  $scope.chess = new Chess
  $scope.heuristic = ->
    n = new Node(@chess.fen())
    n.heuristic()
  $scope.squares = [0..7]
  $scope.getPiece = (x, y) ->
    p = @chess.get(x+y)
    if p then $scope._mapping[p.color][p.type] else ' '
  $scope.selectedClass =  (x, y) ->
    if $scope.currently_selected == (x+y) then 'selected' else 'unselected'
  $scope.colorClass = (i, j) -> 
    if (i + j) % 2 == 0 then 'blackSquares' else 'whiteSquares'
  $scope.move = (move) -> 
    if move in @moves()
      m = @chess.move(move)
    else
      m = @chess.move(move+'+')
      if m then alert('Check!')
    if m then $scope.currently_selected = null
  $scope.moves = -> @chess.moves()
  $scope.play = ->
    unless @chess.game_over()
      console.log "position: " + @chess.fen()
      moves = @chess.moves()
      move = moves[Math.floor(Math.random() * moves.length)]
      @chess.move move
      console.log "move: " + move
  $scope._num_pieces = (piece) ->
    @chess.fen().split(' ')[0].split(piece).length - 1
  $scope._piece_heurstic = (piece, weight) ->
    num_black = @_num_pieces(piece)
    num_white = @_num_pieces(piece.toUpperCase())
    (num_black - num_white) * weight

  $scope.heuristic = ->
    pieces = { p: 1, r: 5, n: 3, q: 9, b: 3, k: 99999 }
    sum = 0
    for p, weight of pieces
      sum += @_piece_heurstic(p, weight)
    sum
  $scope.currentTurn = ->
    fen = @chess.fen()
    if fen.split(' ')[1] == 'w' then "white's" else "black's"
  $scope.currentPlayer = ->
    fen = @chess.fen()
    fen.split(' ')[1]
  $scope.playerClass = ->
    fen = @chess.fen()
    pClass = if fen.split(' ')[1] == 'w' then 'white' else 'black'
  $scope.twoColumns = (i) ->
    if i % 2 == 0 then 'Cright' else 'Cleft'
  $scope.bestMove = ->
    @alpha_beta(new Node(@chess.fen()), 4, -99999, 99999, 1)
  $scope.alpha_beta = (node, depth, alpha, beta, color) ->
    children = node.children()
    if depth == 0 or children.length == 0
      return node.heuristic()
    best = 0

    if color == 1
      for child, i in children
        score = @alpha_beta(child, depth - 1, alpha, beta, -1*color)
        if alpha < score
          alpha = score
          if depth == 4
            best = i
        if beta <= alpha
          break
      console.log(depth) if depth == 4
      if depth == 4
        @chess.move @chess.moves()[best]
      return alpha
    else
      for child, i in children
        score = @alpha_beta(child, depth - 1, alpha, beta, -1*color)
        console.log depth
        if beta > score
          beta = score
        if beta <= alpha
          break
      return beta

class @Node
  constructor: (fen) ->
    @fen = fen
    @squares = @fen_to_a()
    @chess = new Chess(fen)
  children: ->
    moves = @chess.moves()
    moves.map (m) ->
      c = new Chess(@fen)
      c.move(m)
      new Node(c.fen())
  _num_pieces: (piece, str = @fen.split(' ')[0]) ->
    str.split(piece).length - 1
  _piece_heurstic: (piece, weight) ->
    num_black = @_num_pieces(piece)
    num_white = @_num_pieces(piece.toUpperCase())
    (num_black - num_white) * weight
  fen_to_a: ->
    str = @fen.split(' ')[0]
    rows = str.split('/')
    new_rows = []
    for row, i in rows
      new_row = []
      for c, j in row
        num = Number(c)
        if isNaN(num)
          new_row.push(c)
        else
          spaces = (' ' for [1..num])
          new_row = new_row.concat(spaces)
      new_rows.push(new_row)
    new_rows

  heuristic: ->
    pieces = { p: 1, r: 5, n: 3, q: 9, b: 3, k: 99999 }
    sum = 0
    for p, weight of pieces
      sum += @_piece_heurstic(p, weight)
    sum

