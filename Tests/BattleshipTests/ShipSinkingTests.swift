@testable import Battleship
import Testing

// MARK: - Acceptance Tests for Story 4: Detect Ship Sinking

//
// Walking Skeleton: Scenario 1 (sink a Destroyer)
// Milestone 1: Partial hit returns .hit not .sunk
// Milestone 2: Sunk indicator on tracking board (🔥 vs 💥)
// Milestone 3: Announcement + remaining count
// Milestone 4: Progressive sinking updates count
// Milestone 5: Victory on last ship sunk
// Milestone 6: Miss has no effect on sinking
//
// Implementation order: enable tests top-to-bottom, one at a time.
// Disabled tests use placeholder assertions — replace with real
// assertions when enabling.

struct ShipSinkingTests {
    // MARK: - Walking Skeleton: Sink a Destroyer

    @Test(
        """
        Given the enemy has a Destroyer at C3-C4
        And I have already hit C3
        When I fire at C4
        Then the shot result indicates the Destroyer is sunk
        """,
    )
    func sinkDestroyerReturnsCorrectResult() throws {
        let player1 = Player(
            name: "Player 1",
            state: MockPlayerState(),
        )
        let player2 = Player(
            name: "Player 2",
            state: MockPlayerState(),
        )
        try player2.place(
            ship: Destroyer(),
            at: Coordinate(x: .three, y: .C),
            orientation: .horizontal,
        )

        let game = BattleshipGame(
            player1: player1,
            player2: player2,
        )

        // Hit first cell
        let firstShot = game.fire(at: Coordinate(x: .three, y: .C))
        #expect(firstShot == .hit)

        // Hit last cell — should sink
        let sinkingShot = game.fire(at: Coordinate(x: .three, y: .D))
        #expect(sinkingShot == .sunk(shipName: "Destroyer"))
    }

    // MARK: - Milestone 1: Hit without sinking

    @Test(
        """
        Given the enemy has a Cruiser at E5-E7
        And I have already hit E5
        When I fire at E6
        Then the shot result indicates a hit (not sunk)
        """,
    )
    func hitWithoutSinkingReturnsHit() throws {
        let player1 = Player(
            name: "Player 1",
            state: MockPlayerState(),
        )
        let player2 = Player(
            name: "Player 2",
            state: MockPlayerState(),
        )
        try player2.place(
            ship: Cruiser(),
            at: Coordinate(x: .five, y: .E),
            orientation: .vertical,
        )

        let game = BattleshipGame(
            player1: player1,
            player2: player2,
        )

        _ = game.fire(at: Coordinate(x: .five, y: .E))
        let result = game.fire(at: Coordinate(x: .six, y: .E))
        #expect(result == .hit)
    }

    // MARK: - Milestone 2: Sunk indicator on tracking board

    @Test(
        """
        Given the enemy has a Destroyer at B2-B3
        And the enemy has a Carrier at F1-F5
        And I have hit B2 and F1
        When I fire at B3
        Then B2 and B3 show 🔥 on the tracking board
        And F1 still shows 💥
        """,
    )
    func sunkCellsDisplayDifferentlyFromHits() throws {
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
            at: Coordinate(x: .two, y: .B),
            orientation: .vertical,
        )
        try player2.place(
            ship: Carrier(),
            at: Coordinate(x: .one, y: .F),
            orientation: .vertical,
        )

        let game = BattleshipGame(
            player1: player1,
            player2: player2,
        )

        _ = game.fire(at: Coordinate(x: .two, y: .B))
        _ = game.fire(at: Coordinate(x: .one, y: .F))
        _ = game.fire(at: Coordinate(x: .three, y: .B))

        let board =
            """
            Trackingboard
                A  B  C  D  E  F  G  H  I  J
            1                 💥
            2     🔥
            3     🔥
            4
            5
            6
            7
            8
            9
            10
            """

        #expect(playerState.trackingOutput == board)
    }

    // MARK: - Milestone 3: Announcement + remaining count

    @Test(
        """
        Given the enemy has all 5 ships placed
        And I have already hit C3
        When I fire at C4 sinking the Destroyer
        Then I see "You sank the enemy Destroyer!"
        And I see "Enemy ships remaining: 4"
        """,
    )
    func sinkingAnnouncesShipNameAndRemainingCount() throws {
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
            at: Coordinate(x: .three, y: .C),
            orientation: .horizontal,
        )
        try player2.place(
            ship: Carrier(),
            at: Coordinate(x: .one, y: .A),
            orientation: .vertical,
        )
        try player2.place(
            ship: Battleship(),
            at: Coordinate(x: .one, y: .F),
            orientation: .vertical,
        )
        try player2.place(
            ship: Cruiser(),
            at: Coordinate(x: .six, y: .A),
            orientation: .vertical,
        )
        try player2.place(
            ship: Submarine(),
            at: Coordinate(x: .six, y: .F),
            orientation: .vertical,
        )

        let game = BattleshipGame(
            player1: player1,
            player2: player2,
        )

        _ = game.fire(at: Coordinate(x: .three, y: .C))
        _ = game.fire(at: Coordinate(x: .three, y: .D))

        #expect(playerState.messages.contains("You sank the enemy Destroyer!"))
        #expect(playerState.messages.contains("Enemy ships remaining: 4"))
    }

    // MARK: - Milestone 4: Progressive sinking

    @Test(
        """
        Given the enemy has a Destroyer and a Submarine
        And I have already sunk the Destroyer
        When I sink the Submarine
        Then I see "You sank the enemy Submarine!"
        And I see "Enemy ships remaining: 3"
        """,
    )
    func sinkSecondShipUpdatesCount() throws {
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
            at: Coordinate(x: .one, y: .A),
            orientation: .horizontal,
        )
        try player2.place(
            ship: Submarine(),
            at: Coordinate(x: .four, y: .D),
            orientation: .vertical,
        )
        try player2.place(
            ship: Carrier(),
            at: Coordinate(x: .one, y: .F),
            orientation: .vertical,
        )
        try player2.place(
            ship: Battleship(),
            at: Coordinate(x: .six, y: .A),
            orientation: .vertical,
        )
        try player2.place(
            ship: Cruiser(),
            at: Coordinate(x: .six, y: .F),
            orientation: .vertical,
        )

        let game = BattleshipGame(
            player1: player1,
            player2: player2,
        )

        // Sink Destroyer
        _ = game.fire(at: Coordinate(x: .one, y: .A))
        _ = game.fire(at: Coordinate(x: .one, y: .B))

        // Sink Submarine
        _ = game.fire(at: Coordinate(x: .four, y: .D))
        _ = game.fire(at: Coordinate(x: .five, y: .D))
        _ = game.fire(at: Coordinate(x: .six, y: .D))

        #expect(playerState.messages.contains("You sank the enemy Submarine!"))
        #expect(playerState.messages.contains("Enemy ships remaining: 3"))
    }

    // MARK: - Milestone 5: Victory

    @Test(
        """
        Given I have sunk 4 of the 5 enemy ships
        And the enemy has a Carrier as the last ship
        When I sink the Carrier
        Then I see "You sank the enemy Carrier!"
        And I see "Enemy ships remaining: 0"
        And I see "All enemy ships destroyed -- you win!"
        """,
    )
    func sinkLastShipAnnouncesVictory() throws {
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
            ship: Carrier(),
            at: Coordinate(x: .one, y: .A),
            orientation: .vertical,
        )
        try player2.place(
            ship: Battleship(),
            at: Coordinate(x: .one, y: .F),
            orientation: .vertical,
        )
        try player2.place(
            ship: Cruiser(),
            at: Coordinate(x: .six, y: .A),
            orientation: .vertical,
        )
        try player2.place(
            ship: Submarine(),
            at: Coordinate(x: .six, y: .D),
            orientation: .vertical,
        )
        try player2.place(
            ship: Destroyer(),
            at: Coordinate(x: .nine, y: .A),
            orientation: .horizontal,
        )

        let game = BattleshipGame(
            player1: player1,
            player2: player2,
        )

        // Sink Destroyer (A9-B9)
        _ = game.fire(at: Coordinate(x: .nine, y: .A))
        _ = game.fire(at: Coordinate(x: .nine, y: .B))

        // Sink Cruiser (A6-A8)
        _ = game.fire(at: Coordinate(x: .six, y: .A))
        _ = game.fire(at: Coordinate(x: .seven, y: .A))
        _ = game.fire(at: Coordinate(x: .eight, y: .A))

        // Sink Submarine (D6-D8)
        _ = game.fire(at: Coordinate(x: .six, y: .D))
        _ = game.fire(at: Coordinate(x: .seven, y: .D))
        _ = game.fire(at: Coordinate(x: .eight, y: .D))

        // Sink Battleship (F1-F4)
        _ = game.fire(at: Coordinate(x: .one, y: .F))
        _ = game.fire(at: Coordinate(x: .two, y: .F))
        _ = game.fire(at: Coordinate(x: .three, y: .F))
        _ = game.fire(at: Coordinate(x: .four, y: .F))

        // Sink Carrier (A1-A5) — last ship
        _ = game.fire(at: Coordinate(x: .one, y: .A))
        _ = game.fire(at: Coordinate(x: .two, y: .A))
        _ = game.fire(at: Coordinate(x: .three, y: .A))
        _ = game.fire(at: Coordinate(x: .four, y: .A))
        _ = game.fire(at: Coordinate(x: .five, y: .A))

        #expect(playerState.messages.contains("You sank the enemy Carrier!"))
        #expect(playerState.messages.contains("Enemy ships remaining: 0"))
        #expect(
            playerState.messages.contains(
                "All enemy ships destroyed -- you win!",
            ),
        )
    }

    // MARK: - Milestone 6: Miss has no effect

    @Test(
        """
        Given the enemy has a Destroyer at C3-C4
        And I have already hit C3
        When I fire at H8 (open water)
        Then the shot result is a miss
        And no sinking announcement is displayed
        """,
    )
    func missDoesNotAffectSinkingStatus() throws {
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
            at: Coordinate(x: .three, y: .C),
            orientation: .horizontal,
        )

        let game = BattleshipGame(
            player1: player1,
            player2: player2,
        )

        _ = game.fire(at: Coordinate(x: .three, y: .C))
        let result = game.fire(at: Coordinate(x: .eight, y: .H))

        #expect(result == .miss)
        #expect(!playerState.messages.contains { $0.contains("sank") })
    }
}
