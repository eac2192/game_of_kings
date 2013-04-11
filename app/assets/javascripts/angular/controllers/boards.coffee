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

  $scope.currently_selected = null
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
      @tryMove(letter+takes+x+y)
  $scope.chess = new Chess
  $scope.squares = [0..7]
  $scope.tryMove = (move) ->
    if move in @moves()
      m = @chess.move(move)
    else
      m = @chess.move(move+'+')
    if m then $scope.currently_selected = null
  $scope.getPiece = (x, y) ->
    p = @chess.get(x+y)
    if p then $scope._mapping[p.color][p.type] else ' '
  $scope.selectedClass =  (x, y) ->
    if $scope.currently_selected == (x+y) then 'selected' else 'unselected'
  $scope.colorClass = (i, j) -> 
    if (i + j) % 2 == 0 then 'whiteSquares' else 'blackSquares'
  $scope.move = (pos) -> @chess.move(pos)
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
