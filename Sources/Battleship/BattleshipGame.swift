enum ShotResult {
    case miss
    case hit
}

typealias Board = [Coordinate: CellValue]
typealias TrackingBoard = [Coordinate: ShotResult]

protocol PlayerState {
    func currentState(name: String, board: Board, trackingBoard: TrackingBoard)
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
            try placeShip(at: coordinate)
        }
    }

    func value(at coordinate: Coordinate) -> CellValue {
        board[coordinate] ?? .water
    }

    func receiveShot(at coordinate: Coordinate) -> ShotResult {
        value(at: coordinate) == .ship ? .hit : .miss
    }

    func recordShot(at coordinate: Coordinate, result: ShotResult) {
        trackingBoard[coordinate] = result
    }

    private func placeShip(at coordinate: Coordinate) throws {
        guard value(at: coordinate) == .water else {
            throw PlacementError.overlappingShips
        }
        board[coordinate] = .ship
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

    func fire(at coordinate: Coordinate) -> ShotResult {
        let result = player2.receiveShot(at: coordinate)
        player1.recordShot(at: coordinate, result: result)
        return result
    }
}
