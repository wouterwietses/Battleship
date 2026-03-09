enum ShotResult: Equatable {
    case miss
    case hit
    case sunk(shipName: String)
}

typealias Board = [Coordinate: CellValue]
typealias TrackingBoard = [Coordinate: ShotResult]

protocol PlayerState {
    func currentState(name: String, board: Board, trackingBoard: TrackingBoard)
    func displayMessage(_ message: String)
}

final class Player {
    private let state: any PlayerState
    private let name: String
    private var board: Board {
        didSet {
            state.currentState(name: name, board: board, trackingBoard: trackingBoard)
        }
    }

    private var trackingBoard: TrackingBoard {
        didSet {
            state.currentState(name: name, board: board, trackingBoard: trackingBoard)
        }
    }

    private var shipCoordinates: [String: Set<Coordinate>] = [:]
    private var hitCoordinates: Set<Coordinate> = []

    init(name: String, state: any PlayerState) {
        self.name = name
        board = [:]
        trackingBoard = [:]
        self.state = state
        state.currentState(name: name, board: board, trackingBoard: trackingBoard)
    }

    func place(
        ship: any Ship, at coordinate: Coordinate, orientation: Orientation,
    ) throws {
        let coordinates = try coordinatesForShipPlacement(
            ship: ship,
            at: coordinate,
            orientation: orientation,
        )

        for coordinate in coordinates {
            try placeShip(name: ship.name, at: coordinate)
        }

        shipCoordinates[ship.name, default: []].formUnion(coordinates)
    }

    func value(at coordinate: Coordinate) -> CellValue {
        board[coordinate] ?? .water
    }

    func receiveShot(at coordinate: Coordinate) -> ShotResult {
        switch value(at: coordinate) {
        case .water:
            return .miss
        case let .ship(shipName):
            hitCoordinates.insert(coordinate)
            if let coords = shipCoordinates[shipName],
               coords.isSubset(of: hitCoordinates) {
                return .sunk(shipName: shipName)
            }
            return .hit
        }
    }

    func recordShot(at coordinate: Coordinate, result: ShotResult) {
        trackingBoard[coordinate] = result
    }

    func recordSunkShip(name: String, coordinates: Set<Coordinate>) {
        for coord in coordinates {
            trackingBoard[coord] = .sunk(shipName: name)
        }
    }

    func coordinatesForShip(named name: String) -> Set<Coordinate> {
        shipCoordinates[name] ?? []
    }

    func displayMessage(_ message: String) {
        state.displayMessage(message)
    }

    var totalShipCount: Int {
        shipCoordinates.count
    }

    private func placeShip(name: String, at coordinate: Coordinate) throws {
        guard value(at: coordinate) == .water else {
            throw PlacementError.overlappingShips
        }
        board[coordinate] = .ship(name: name)
    }

    private func coordinatesForShipPlacement(
        ship: any Ship,
        at coordinate: Coordinate,
        orientation: Orientation,
    ) throws -> [Coordinate] {
        var coordinates: [Coordinate] = []

        for lengthIndex in 0 ..< ship.length {
            switch orientation {
            case .vertical:
                guard let newX = XAxis(rawValue: coordinate.x.rawValue + lengthIndex) else {
                    throw PlacementError.outOfBounds
                }
                coordinates.append(Coordinate(x: newX, y: coordinate.y))
            case .horizontal:
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
