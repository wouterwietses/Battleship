@testable import Battleship
import Testing

@Suite("As a player I want to see an empty game board So that I can visualize the battlefield")
struct EmptyBoardTests {
    @Test
    func shouldDisplayWaterAtLocationA1() async throws {
        let board = BattleshipBoard()

        let value = board.value(at: Coordinate(latitude: "1", longitude: "A"))
        #expect(value == .water)
    }
}
