enum ShotResult: Equatable {
    case miss
    case hit
    case sunk(shipName: String)
}
