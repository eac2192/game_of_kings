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

  $scope.chess = new Chess
  $scope.heuristic = ->
    n = new Node(@chess.fen())
    n.heuristic()
  $scope.squares = [0..7]
  $scope.getPiece = (x, y) ->
    p = @chess.get(x+y)
    if p then $scope._mapping[p.color][p.type] else ' '
  $scope.colorClass = (i, j) -> if (i + j) % 2 == 0 then 'whiteSquares' else 'blackSquares'
  $scope.move = (pos) -> @chess.move(pos)
  $scope.moves = -> @chess.moves()
  $scope.play = ->
    unless @chess.game_over()
      console.log "position: " + @chess.fen()
      moves = @chess.moves()
      move = moves[Math.floor(Math.random() * moves.length)]
      @chess.move move
      console.log "move: " + move
  $scope.bestMove = ->
    @negamax(new Node(@chess.fen()), 2, -99999, 99999, 1)
  $scope.negamax = (node, depth, alpha, beta, color) ->
    console.log '.'
    children = node.children()
    if depth == 0 or children.length == 0
      return color * node.heuristic()
    best = 0
    for child, i in children
      val = $scope.negamax(child, depth - 1, -1*beta, -1*alpha, -1*color)
      if val >= beta
        if depth == 2
          $scope.chess.move $scope.chess.moves()[i]
        return val
      if val > alpha
        best = i
        alpha = val
    if depth == 2
      $scope.chess.move $scope.chess.moves()[best]
    return alpha

class @Node
  constructor: (fen) ->
    @fen = fen
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
  heuristic: ->
    pieces = { p: 1, r: 5, n: 3, q: 9, b: 3, k: 99999 }
    sum = 0
    for p, weight of pieces
      sum += @_piece_heurstic(p, weight)
    sum

