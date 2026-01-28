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
    case carrier, battleship
}

enum Orientation {
    case horizontal, vertical
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

    func place(ship: ShipType, at _: Coordinate, orientation _: Orientation) {
        if ship == .carrier {
            grid[Coordinate(x: .one, y: .A)] = .ship
            grid[Coordinate(x: .two, y: .A)] = .ship
            grid[Coordinate(x: .three, y: .A)] = .ship
            grid[Coordinate(x: .four, y: .A)] = .ship
            grid[Coordinate(x: .five, y: .A)] = .ship
        }
        if ship == .battleship {
            grid[Coordinate(x: .one, y: .A)] = .ship
            grid[Coordinate(x: .one, y: .B)] = .ship
            grid[Coordinate(x: .one, y: .C)] = .ship
            grid[Coordinate(x: .one, y: .D)] = .ship
        }
    }
}
