@BoardsController = ($scope) ->
  $scope._board = new Board
  $scope.squares = $scope._board.spaces
  $scope.colorClass = (i, j) -> if (i + j) % 2 == 0 then 'whiteSquares' else 'blackSquares'
  $scope.move = (positions) ->
    $scope._board.move(positions)

