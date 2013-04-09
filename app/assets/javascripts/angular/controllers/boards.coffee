@BoardsController = ($scope) ->
  $scope.hello = "hi"
  $scope._board = new Board
  $scope.squares = $scope._board.spaces
  $scope.classFor = (i, j) -> if (i + j) % 2 == 0 then 'whiteSquares' else 'blackSquares'
  console.log $scope._board

