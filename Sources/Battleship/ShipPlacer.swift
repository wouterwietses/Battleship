enum ShipPlacer {
    static func coordinates(
        for ship: any Ship,
        at origin: Coordinate,
        orientation: Orientation,
    ) throws -> [Coordinate] {
        var coordinates: [Coordinate] = []

        for offset in 0 ..< ship.length {
            switch orientation {
            case .vertical:
                guard let newX = XAxis(rawValue: origin.x.rawValue + offset) else {
                    throw PlacementError.outOfBounds
                }
                coordinates.append(Coordinate(x: newX, y: origin.y))
            case .horizontal:
                let allColumns = YAxis.allCases
                guard let currentIndex = allColumns.firstIndex(of: origin.y),
                      currentIndex + offset < allColumns.count
                else {
                    throw PlacementError.outOfBounds
                }

                let newY = allColumns[currentIndex + offset]
                coordinates.append(Coordinate(x: origin.x, y: newY))
            }
        }

        return coordinates
    }
}
