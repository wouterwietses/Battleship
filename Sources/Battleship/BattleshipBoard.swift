enum XAxis: CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine, ten
}

enum YAxis: CaseIterable {
    // swiftlint:disable identifier_name
    case A, B, C, D, E, F, G, H, I, J
    // swiftlint:enable identifier_name
}

struct Coordinate {
    // swiftlint:disable identifier_name
    let x: XAxis
    let y: YAxis
    // swiftlint:enable identifier_name
}

enum CellValue {
    case water
}

struct BattleshipBoard {
    func value(at _: Coordinate) -> CellValue {
        .water
    }
}
