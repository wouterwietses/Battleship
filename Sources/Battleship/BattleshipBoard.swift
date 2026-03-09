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
        let coordinates = try coordinatesForShipPlacement(
            ship: ship,
            at: coordinate,
            orientation: orientation,
        )

        for coordinate in coordinates {
            try placeShip(name: ship.name, at: coordinate)
        }
    }

    private func coordinatesForShipPlacement(
        ship: any Ship,
        at coordinate: Coordinate,
        orientation: Orientation,
    ) throws -> [Coordinate] {
        var coordinates: [Coordinate] = []

        for lengthIndex in 0 ..< ship.length {
            switch orientation {
            case .horizontal:
                guard let newX = XAxis(rawValue: coordinate.x.rawValue + lengthIndex) else {
                    throw PlacementError.outOfBounds
                }
                coordinates.append(Coordinate(x: newX, y: coordinate.y))
            case .vertical:
                let allYAxes = YAxis.allCases
                guard let currentIndex = allYAxes.firstIndex(of: coordinate.y),
                      currentIndex + lengthIndex < allYAxes.count
                else {
                    throw PlacementError.outOfBounds
                }

                let newY = allYAxes[currentIndex + lengthIndex]
                coordinates.append(Coordinate(x: coordinate.x, y: newY))
            }
        }

        return coordinates
    }
}
