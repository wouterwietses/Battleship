enum Latitude: CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine, ten
}

enum Longitude: CaseIterable {
    // swiftlint:disable identifier_name
    case A, B, C, D, E, F, G, H, I, J
    // swiftlint:enable identifier_name
}

struct Coordinate {
    let latitude: Latitude
    let longitude: Longitude
}

enum CellValue {
    case water
}

struct BattleshipBoard {
    func value(at _: Coordinate) -> CellValue {
        .water
    }
}
