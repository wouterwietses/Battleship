import Testing

@testable import Battleship

@Suite(
    "As a player I want to fire at coordinates on the enemy board so that I can try to sink their ships",
)
struct ShotTests {
    @Test(
        "Given the game has started with all ships placed When I fire at coordinate B5 Then the tracking board shows ❌ at B5 And I receive feedback Miss!",
    )
    func fireAndMiss() async throws {
        let board = BattleshipBoard(playerName: "Player 1")
        try board.place(ship: Carrier(), at: Coordinate(x: .one, y: .A), orientation: .horizontal)
        try board.place(
            ship: Battleship(), at: Coordinate(x: .one, y: .B), orientation: .horizontal,
        )
        try board.place(ship: Cruiser(), at: Coordinate(x: .one, y: .C), orientation: .horizontal)
        try board.place(ship: Submarine(), at: Coordinate(x: .one, y: .D), orientation: .horizontal)
        try board.place(ship: Destroyer(), at: Coordinate(x: .one, y: .E), orientation: .horizontal)

        let game = BattleshipGame(
            player1Board: board,
            player2Board: BattleshipBoard(playerName: "Player 2"),
        )

        let result = game.fire(at: Coordinate(x: .five, y: .B))
        #expect(result == .miss)

        let value = board.trackingBoardValue(at: Coordinate(x: .five, y: .B))
        #expect(value == .miss)
    }
}
