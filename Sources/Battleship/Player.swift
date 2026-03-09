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
        let coordinates = try ShipPlacer.coordinates(
            for: ship,
            at: coordinate,
            orientation: orientation,
        )

        for coord in coordinates {
            try placeShip(name: ship.name, at: coord)
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
}
