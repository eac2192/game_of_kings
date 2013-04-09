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
  $scope.squares = [0..7]
  $scope.getPiece = (x, y) ->
    p = @chess.get(x+y)
    if p then $scope._mapping[p.color][p.type] else ' '
  $scope.colorClass = (i, j) -> if (i + j) % 2 == 0 then 'whiteSquares' else 'blackSquares'

