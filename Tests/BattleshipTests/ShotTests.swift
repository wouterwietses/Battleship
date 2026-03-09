@testable import Battleship
import Testing

struct CoordinateParsingArguments {
    let input: String
    let expected: Coordinate
}

struct CoordinateParsingTests {
    @Test(
        "Should parse coordinate string",
        arguments: [
            CoordinateParsingArguments(input: "B5", expected: Coordinate(x: .five, y: .B)),
            CoordinateParsingArguments(input: "A1", expected: Coordinate(x: .one, y: .A)),
            CoordinateParsingArguments(input: "J10", expected: Coordinate(x: .ten, y: .J))
        ],
    )
    func parseCoordinate(arguments: CoordinateParsingArguments) throws {
        let coordinate = try Coordinate(arguments.input)
        #expect(coordinate == arguments.expected)
    }

    @Test(
        "Should reject invalid coordinate string",
        arguments: ["", "Z1", "A0", "A11", "1A", "AA"],
    )
    func rejectInvalidCoordinate(input: String) throws {
        #expect(throws: CoordinateParsingError.self) {
            try Coordinate(input)
        }
    }
}

struct ShotTests {
    @Test(
        """
        Given the game has started with all ships placed
        When I fire at coordinate B5
        Then the tracking board shows ❌ at B5
        And I receive feedback Miss!
        """,
    )
    func fireAndMiss() {
        let playerState = MockPlayerState()
        let player1 = Player(
            name: "Player 1",
            state: playerState,
        )
        let game = BattleshipGame(
            player1: player1,
            player2: Player(name: "Player 2", state: MockPlayerState()),
        )

        let result = game.fire(at: Coordinate(x: .five, y: .B))
        #expect(result == .miss)

        let board =
            """
            Trackingboard
                A  B  C  D  E  F  G  H  I  J
            1
            2
            3
            4
            5     ❌
            6
            7
            8
            9
            10

            Player 1
                A  B  C  D  E  F  G  H  I  J
            1  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            2  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            3  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            4  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            5  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            6  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            7  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            8  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            9  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            10 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            """

        #expect(playerState.output == board)
    }

    @Test(
        """
        Given the game has started with all ships placed
        And one of the ship has a piece placed on B5
        When I fire at coordinate B5
        Then the tracking board shows 💥 at B5
        And I receive feedback "Hit!"
        """,
    )
    func fireAndHit() throws {
        let playerState = MockPlayerState()
        let player1 = Player(
            name: "Player 1",
            state: playerState,
        )
        let player2 = Player(
            name: "Player 2",
            state: MockPlayerState(),
        )
        try player2.place(
            ship: Destroyer(),
            at: Coordinate(x: .five, y: .B),
            orientation: .horizontal,
        )

        let game = BattleshipGame(
            player1: player1,
            player2: player2,
        )

        let result = game.fire(at: Coordinate(x: .five, y: .B))
        #expect(result == .hit)

        let board =
            """
            Trackingboard
                A  B  C  D  E  F  G  H  I  J
            1
            2
            3
            4
            5     💥
            6
            7
            8
            9
            10

            Player 1
                A  B  C  D  E  F  G  H  I  J
            1  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            2  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            3  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            4  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            5  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            6  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            7  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            8  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            9  🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            10 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊 🌊
            """

        #expect(playerState.output == board)
    }
}
