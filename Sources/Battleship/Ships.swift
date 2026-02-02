protocol Ship: Sendable {
    var length: Int { get }
}

struct Carrier: Ship {
    let length: Int = 5
}

struct Battleship: Ship {
    let length: Int = 4
}

struct Cruiser: Ship {
    let length: Int = 3
}

struct Submarine: Ship {
    let length: Int = 3
}

struct Destroyer: Ship {
    let length: Int = 2
}
