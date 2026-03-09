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

    static func from(_ string: String) -> YAxis? {
        allCases.first { String(describing: $0) == string }
    }
}

enum CoordinateParsingError: Error {
    case invalidFormat
    case invalidColumn
    case invalidRow
}

struct Coordinate: Hashable {
    // swiftlint:disable identifier_name
    let x: XAxis
    let y: YAxis
    // swiftlint:enable identifier_name

    // swiftlint:disable:next identifier_name
    init(x: XAxis, y: YAxis) {
        self.x = x
        self.y = y
    }

    init(_ input: String) throws {
        guard let first = input.first,
              first.isLetter
        else {
            throw CoordinateParsingError.invalidFormat
        }

        let columnString = String(first).uppercased()
        let rowString = String(input.dropFirst())

        guard let column = YAxis.from(columnString) else {
            throw CoordinateParsingError.invalidColumn
        }

        guard let rowNumber = Int(rowString),
              let row = XAxis(rawValue: rowNumber)
        else {
            throw CoordinateParsingError.invalidRow
        }

        x = row
        y = column
    }
}

extension Coordinate {
    static let A1 = Coordinate(x: .one, y: .A)
    static let B1 = Coordinate(x: .one, y: .B)
    static let C1 = Coordinate(x: .one, y: .C)
    static let D1 = Coordinate(x: .one, y: .D)
    static let E1 = Coordinate(x: .one, y: .E)
    static let F1 = Coordinate(x: .one, y: .F)
    static let G1 = Coordinate(x: .one, y: .G)
    static let H1 = Coordinate(x: .one, y: .H)
    static let I1 = Coordinate(x: .one, y: .I)
    static let J1 = Coordinate(x: .one, y: .J)
    static let A2 = Coordinate(x: .two, y: .A)
    static let B2 = Coordinate(x: .two, y: .B)
    static let C2 = Coordinate(x: .two, y: .C)
    static let D2 = Coordinate(x: .two, y: .D)
    static let E2 = Coordinate(x: .two, y: .E)
    static let F2 = Coordinate(x: .two, y: .F)
    static let G2 = Coordinate(x: .two, y: .G)
    static let H2 = Coordinate(x: .two, y: .H)
    static let I2 = Coordinate(x: .two, y: .I)
    static let J2 = Coordinate(x: .two, y: .J)
    static let A3 = Coordinate(x: .three, y: .A)
    static let B3 = Coordinate(x: .three, y: .B)
    static let C3 = Coordinate(x: .three, y: .C)
    static let D3 = Coordinate(x: .three, y: .D)
    static let E3 = Coordinate(x: .three, y: .E)
    static let F3 = Coordinate(x: .three, y: .F)
    static let G3 = Coordinate(x: .three, y: .G)
    static let H3 = Coordinate(x: .three, y: .H)
    static let I3 = Coordinate(x: .three, y: .I)
    static let J3 = Coordinate(x: .three, y: .J)
    static let A4 = Coordinate(x: .four, y: .A)
    static let B4 = Coordinate(x: .four, y: .B)
    static let C4 = Coordinate(x: .four, y: .C)
    static let D4 = Coordinate(x: .four, y: .D)
    static let E4 = Coordinate(x: .four, y: .E)
    static let F4 = Coordinate(x: .four, y: .F)
    static let G4 = Coordinate(x: .four, y: .G)
    static let H4 = Coordinate(x: .four, y: .H)
    static let I4 = Coordinate(x: .four, y: .I)
    static let J4 = Coordinate(x: .four, y: .J)
    static let A5 = Coordinate(x: .five, y: .A)
    static let B5 = Coordinate(x: .five, y: .B)
    static let C5 = Coordinate(x: .five, y: .C)
    static let D5 = Coordinate(x: .five, y: .D)
    static let E5 = Coordinate(x: .five, y: .E)
    static let F5 = Coordinate(x: .five, y: .F)
    static let G5 = Coordinate(x: .five, y: .G)
    static let H5 = Coordinate(x: .five, y: .H)
    static let I5 = Coordinate(x: .five, y: .I)
    static let J5 = Coordinate(x: .five, y: .J)
    static let A6 = Coordinate(x: .six, y: .A)
    static let B6 = Coordinate(x: .six, y: .B)
    static let C6 = Coordinate(x: .six, y: .C)
    static let D6 = Coordinate(x: .six, y: .D)
    static let E6 = Coordinate(x: .six, y: .E)
    static let F6 = Coordinate(x: .six, y: .F)
    static let G6 = Coordinate(x: .six, y: .G)
    static let H6 = Coordinate(x: .six, y: .H)
    static let I6 = Coordinate(x: .six, y: .I)
    static let J6 = Coordinate(x: .six, y: .J)
    static let A7 = Coordinate(x: .seven, y: .A)
    static let B7 = Coordinate(x: .seven, y: .B)
    static let C7 = Coordinate(x: .seven, y: .C)
    static let D7 = Coordinate(x: .seven, y: .D)
    static let E7 = Coordinate(x: .seven, y: .E)
    static let F7 = Coordinate(x: .seven, y: .F)
    static let G7 = Coordinate(x: .seven, y: .G)
    static let H7 = Coordinate(x: .seven, y: .H)
    static let I7 = Coordinate(x: .seven, y: .I)
    static let J7 = Coordinate(x: .seven, y: .J)
    static let A8 = Coordinate(x: .eight, y: .A)
    static let B8 = Coordinate(x: .eight, y: .B)
    static let C8 = Coordinate(x: .eight, y: .C)
    static let D8 = Coordinate(x: .eight, y: .D)
    static let E8 = Coordinate(x: .eight, y: .E)
    static let F8 = Coordinate(x: .eight, y: .F)
    static let G8 = Coordinate(x: .eight, y: .G)
    static let H8 = Coordinate(x: .eight, y: .H)
    static let I8 = Coordinate(x: .eight, y: .I)
    static let J8 = Coordinate(x: .eight, y: .J)
    static let A9 = Coordinate(x: .nine, y: .A)
    static let B9 = Coordinate(x: .nine, y: .B)
    static let C9 = Coordinate(x: .nine, y: .C)
    static let D9 = Coordinate(x: .nine, y: .D)
    static let E9 = Coordinate(x: .nine, y: .E)
    static let F9 = Coordinate(x: .nine, y: .F)
    static let G9 = Coordinate(x: .nine, y: .G)
    static let H9 = Coordinate(x: .nine, y: .H)
    static let I9 = Coordinate(x: .nine, y: .I)
    static let J9 = Coordinate(x: .nine, y: .J)
    static let A10 = Coordinate(x: .ten, y: .A)
    static let B10 = Coordinate(x: .ten, y: .B)
    static let C10 = Coordinate(x: .ten, y: .C)
    static let D10 = Coordinate(x: .ten, y: .D)
    static let E10 = Coordinate(x: .ten, y: .E)
    static let F10 = Coordinate(x: .ten, y: .F)
    static let G10 = Coordinate(x: .ten, y: .G)
    static let H10 = Coordinate(x: .ten, y: .H)
    static let I10 = Coordinate(x: .ten, y: .I)
    static let J10 = Coordinate(x: .ten, y: .J)
}

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
