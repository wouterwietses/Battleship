import Testing

@testable import Battleship

@Suite("As a player I want to see an empty game board So that I can visualize the battlefield")
struct EmptyBoardTests {
    @Test("Should display water at location:", arguments: XAxis.allCases, YAxis.allCases)
    func shouldDisplayWaterAtLocationA1(xAxis: XAxis, yAxis: YAxis) async throws {
        let board = BattleshipBoard(playerName: "")

        let value = board.value(at: Coordinate(x: xAxis, y: yAxis))
        #expect(value == .water)
    }

    @Test("Should display player name")
    func shouldDisplayPlayerName() async throws {
        let board = BattleshipBoard(playerName: "Player 1")

        #expect(board.playerName == "Player 1")
    }
}

@Suite("As a player I want to place my fleet on the board So that I can prepare for battle")
struct PlaceShipsTests {
    @Test
    func placeCarrier() async throws {
        let board = BattleshipBoard(playerName: "Player 1")

        board.place(ship: .carrier, at: Coordinate(x: .one, y: .A), orientation: .horizontal)

        let coordinates = [
            Coordinate(x: .one, y: .A),
            Coordinate(x: .two, y: .A),
            Coordinate(x: .three, y: .A),
            Coordinate(x: .four, y: .A),
            Coordinate(x: .five, y: .A)
        ]
        for coordinate in coordinates {
            let value = board.value(at: coordinate)
            #expect(value == .ship)
        }
    }
}
