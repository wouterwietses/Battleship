final class BattleshipGame {
    private let player1: Player
    private let player2: Player

    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }

    private var sunkShipCount: Int = 0

    func fire(at coordinate: Coordinate) -> ShotResult {
        let result = player2.receiveShot(at: coordinate)
        player1.recordShot(at: coordinate, result: result)

        if case let .sunk(shipName) = result {
            let coords = player2.coordinatesForShip(named: shipName)
            player1.recordSunkShip(name: shipName, coordinates: coords)

            sunkShipCount += 1
            let remaining = player2.totalShipCount - sunkShipCount

            player1.displayMessage("You sank the enemy \(shipName)!")
            player1.displayMessage("Enemy ships remaining: \(remaining)")

            if remaining == 0 {
                player1.displayMessage(
                    "All enemy ships destroyed -- you win!",
                )
            }
        }

        return result
    }
}
