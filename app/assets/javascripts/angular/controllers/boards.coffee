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
    #@prev = @currently_selected
    if p 
      $scope.currently_selected = x+y
    else
      selected = @chess.get($scope.currently_selected)
      letter =  if selected.type isnt 'p' then selected.type.toUpperCase() else ''
      @chess.move(letter+x+y)
    #@selectedClass(@prev)
  $scope.chess = new Chess
  $scope.squares = [0..7]
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

