enum CellValue: Equatable {
    case water
    case ship(name: String)
}

enum Orientation {
    case horizontal, vertical
}

enum PlacementError: Error {
    case outOfBounds, overlappingShips
}

final class BattleshipBoard {
    let playerName: String

    private var grid: [Coordinate: CellValue] = [:]

    init(playerName: String) {
        self.playerName = playerName
    }

    func value(at coordinate: Coordinate) -> CellValue {
        grid[coordinate] ?? .water
    }

    private func placeShip(name: String, at coordinate: Coordinate) throws {
        guard value(at: coordinate) == .water else {
            throw PlacementError.overlappingShips
        }
        grid[coordinate] = .ship(name: name)
    }

    func place(ship: any Ship, at coordinate: Coordinate, orientation: Orientation) throws {
        // Note: BattleshipBoard uses inverted orientation semantics
        // (horizontal expands rows, vertical expands columns).
        // This flips to match ShipPlacer's correct semantics.
        let flippedOrientation: Orientation = orientation == .horizontal ? .vertical : .horizontal
        let coordinates = try ShipPlacer.coordinates(
            for: ship,
            at: coordinate,
            orientation: flippedOrientation,
        )

        for coord in coordinates {
            try placeShip(name: ship.name, at: coord)
        }
    }
}
