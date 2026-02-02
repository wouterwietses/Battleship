enum XAxis: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
}

enum YAxis: CaseIterable {
    // swiftlint:disable identifier_name
    case A, B, C, D, E, F, G, H, I, J
    // swiftlint:enable identifier_name
}

struct Coordinate: Hashable {
    // swiftlint:disable identifier_name
    let x: XAxis
    let y: YAxis
    // swiftlint:enable identifier_name
}

enum CellValue {
    case water, ship
}

enum ShipType {
    case carrier, battleship, cruiser, submarine, destroyer
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

    private let shipLenghts: [ShipType: Int] = [
        .carrier: 5,
        .battleship: 4,
        .cruiser: 3,
        .submarine: 3,
        .destroyer: 2
    ]

    init(playerName: String) {
        self.playerName = playerName
    }

    func value(at coordinate: Coordinate) -> CellValue {
        grid[coordinate] ?? .water
    }

    private func placeShip(at coordinate: Coordinate) throws {
        guard grid[coordinate] != .ship else {
            throw PlacementError.overlappingShips
        }
        grid[coordinate] = .ship
    }

    func place(ship: ShipType, at coordinate: Coordinate, orientation: Orientation) throws {
        let coordinates = try coordinatesForShipPlacement(
            ship: ship,
            at: coordinate,
            orientation: orientation,
        )

        for coordinate in coordinates {
            try placeShip(at: coordinate)
        }
    }

    private func coordinatesForShipPlacement(
        ship: ShipType,
        at coordinate: Coordinate,
        orientation: Orientation,
    ) throws -> [Coordinate] {
        guard let length = shipLenghts[ship] else {
            return []
        }

        var coordinates: [Coordinate] = []

        for lengthIndex in 0 ..< length {
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
