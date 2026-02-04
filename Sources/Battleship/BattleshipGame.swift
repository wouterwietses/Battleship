enum ShotResult {
    case miss
}

final class BattleshipGame {
    let player1Board: BattleshipBoard
    let player2Board: BattleshipBoard

    init(player1Board: BattleshipBoard, player2Board: BattleshipBoard) {
        self.player1Board = player1Board
        self.player2Board = player2Board
    }

    func fire(at _: Coordinate) -> ShotResult {
        .miss
    }
}
