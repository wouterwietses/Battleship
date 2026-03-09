@testable import Battleship
import Testing

struct EmptyBoardTests {
    @Test("Should display water at location:", arguments: XAxis.allCases, YAxis.allCases)
    func shouldDisplayWaterAtLocationA1(xAxis: XAxis, yAxis: YAxis) {
        let board = BattleshipBoard(playerName: "")

        let value = board.value(at: Coordinate(x: xAxis, y: yAxis))
        #expect(value == .water)
    }

    @Test("Should display player name")
    func shouldDisplayPlayerName() {
        let board = BattleshipBoard(playerName: "Player 1")

        #expect(board.playerName == "Player 1")
    }
}

struct PlaceShipArguments {
    let ship: any Ship
    let coordinate: Coordinate
    let orientation: Orientation
    let expectedCoordinates: [Coordinate]
}

struct PlaceShipsTests {
    @Test(
        "Should place ship on the board",
        arguments: [
            PlaceShipArguments(
                ship: Carrier(),
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
                ship: Battleship(),
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
                ship: Cruiser(),
                coordinate: Coordinate(x: .one, y: .A),
                orientation: .horizontal,
                expectedCoordinates: [
                    Coordinate(x: .one, y: .A),
                    Coordinate(x: .two, y: .A),
                    Coordinate(x: .three, y: .A)
                ],
            ),
            PlaceShipArguments(
                ship: Submarine(),
                coordinate: Coordinate(x: .one, y: .A),
                orientation: .vertical,
                expectedCoordinates: [
                    Coordinate(x: .one, y: .A),
                    Coordinate(x: .one, y: .B),
                    Coordinate(x: .one, y: .C)
                ],
            ),
            PlaceShipArguments(
                ship: Destroyer(),
                coordinate: Coordinate(x: .one, y: .A),
                orientation: .horizontal,
                expectedCoordinates: [
                    Coordinate(x: .one, y: .A),
                    Coordinate(x: .two, y: .A)
                ],
            )
        ],
    )
    func placeCarrier(arguments: PlaceShipArguments) throws {
        let board = BattleshipBoard(playerName: "Player 1")

        try board.place(
            ship: arguments.ship, at: arguments.coordinate, orientation: arguments.orientation,
        )

        for coordinate in arguments.expectedCoordinates {
            let value = board.value(at: coordinate)
            #expect(value != .water)
        }
    }

    @Test(
        "Should not place ship out of bounds",
        arguments: [Orientation.horizontal, Orientation.vertical],
    )
    func shouldNotPlaceShipOutOfBounds(orientation: Orientation) throws {
        let board = BattleshipBoard(playerName: "Player 1")

        #expect(throws: PlacementError.outOfBounds) {
            try board.place(
                ship: Destroyer(),
                at: Coordinate(x: .ten, y: .J),
                orientation: orientation,
            )
        }
    }

    @Test func shipsShouldNotOverlap() throws {
        let board = BattleshipBoard(playerName: "Player 1")

        try board.place(
            ship: Destroyer(),
            at: Coordinate(x: .one, y: .A),
            orientation: .horizontal,
        )
        #expect(throws: PlacementError.overlappingShips) {
            try board.place(
                ship: Destroyer(),
                at: Coordinate(x: .one, y: .A),
                orientation: .vertical,
            )
        }
    }
}
