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

struct PlaceShipArguments {
    let shipType: ShipType
    let coordinate: Coordinate
    let orientation: Orientation
    let expectedCoordinates: [Coordinate]
}

@Suite("As a player I want to place my fleet on the board So that I can prepare for battle")
struct PlaceShipsTests {
    @Test(
        "Should place ship on the board",
        arguments: [
            PlaceShipArguments(
                shipType: .carrier,
                coordinate: Coordinate(x: .one, y: .A),
                orientation: .horizontal,
                expectedCoordinates: [
                    Coordinate(x: .one, y: .A),
                    Coordinate(x: .two, y: .A),
                    Coordinate(x: .three, y: .A),
                    Coordinate(x: .four, y: .A),
                    Coordinate(x: .five, y: .A)
                ],
            ),
            PlaceShipArguments(
                shipType: .battleship,
                coordinate: Coordinate(x: .one, y: .A),
                orientation: .vertical,
                expectedCoordinates: [
                    Coordinate(x: .one, y: .A),
                    Coordinate(x: .one, y: .B),
                    Coordinate(x: .one, y: .C),
                    Coordinate(x: .one, y: .D)
                ],
            ),
            PlaceShipArguments(
                shipType: .cruiser,
                coordinate: Coordinate(x: .one, y: .A),
                orientation: .horizontal,
                expectedCoordinates: [
                    Coordinate(x: .one, y: .A),
                    Coordinate(x: .two, y: .A),
                    Coordinate(x: .three, y: .A)
                ],
            ),
            PlaceShipArguments(
                shipType: .submarine,
                coordinate: Coordinate(x: .one, y: .A),
                orientation: .vertical,
                expectedCoordinates: [
                    Coordinate(x: .one, y: .A),
                    Coordinate(x: .one, y: .B),
                    Coordinate(x: .one, y: .C)
                ],
            ),
            PlaceShipArguments(
                shipType: .destroyer,
                coordinate: Coordinate(x: .one, y: .A),
                orientation: .horizontal,
                expectedCoordinates: [
                    Coordinate(x: .one, y: .A),
                    Coordinate(x: .two, y: .A)
                ],
            )
        ],
    )
    func placeCarrier(arguments: PlaceShipArguments) async throws {
        let board = BattleshipBoard(playerName: "Player 1")

        try board.place(
            ship: arguments.shipType, at: arguments.coordinate, orientation: arguments.orientation,
        )

        for coordinate in arguments.expectedCoordinates {
            let value = board.value(at: coordinate)
            #expect(value == .ship)
        }
    }

    @Test(
        "Should not place ship out of bounds",
        arguments: [Orientation.horizontal, Orientation.vertical],
    )
    func shouldNotPlaceShipOutOfBounds(orientation: Orientation) async throws {
        let board = BattleshipBoard(playerName: "Player 1")

        #expect(throws: PlacementError.outOfBounds) {
            try board.place(
                ship: .destroyer,
                at: Coordinate(x: .ten, y: .J),
                orientation: orientation,
            )
        }
    }

    @Test func shipsShouldNotOverlap() async throws {
        #expect(Bool(false), "Add tests for overlapping ships")
    }
}
