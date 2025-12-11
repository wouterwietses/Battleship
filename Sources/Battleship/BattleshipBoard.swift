struct Coordinate {
    let latitude: String
    let longitude: String
}

enum CellValue {
    case water
}

struct BattleshipBoard {
    func value(at _: Coordinate) -> CellValue {
        .water
    }
}
