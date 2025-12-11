@testable import Battleship
import Testing

@Suite("As a player I want to see an empty game board So that I can visualize the battlefield")
struct EmptyBoardTests {
    @Test("Should display water at location:", arguments: Latitude.allCases, Longitude.allCases)
    func shouldDisplayWaterAtLocationA1(latitude: Latitude, longitude: Longitude) async throws {
        let board = BattleshipBoard()

        let value = board.value(at: Coordinate(latitude: latitude, longitude: longitude))
        #expect(value == .water)
    }
}
