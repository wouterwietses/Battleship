typealias Board = [Coordinate: CellValue]
typealias TrackingBoard = [Coordinate: ShotResult]

protocol PlayerState {
    func currentState(name: String, board: Board, trackingBoard: TrackingBoard)
    func displayMessage(_ message: String)
}
