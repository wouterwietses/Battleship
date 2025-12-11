@testable import Battleship
import Testing

@Suite("As a player I want to see an empty game board So that I can visualize the battlefield")
struct EmptyBoardTests {
    @Test("Should display water at location:", arguments: XAxis.allCases, YAxis.allCases)
    func shouldDisplayWaterAtLocationA1(xAxis: XAxis, yAxis: YAxis) async throws {
        let board = BattleshipBoard()

        let value = board.value(at: Coordinate(x: xAxis, y: yAxis))
        #expect(value == .water)
    }
}
