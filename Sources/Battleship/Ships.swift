protocol Ship: Sendable {
    var length: Int { get }
    var name: String { get }
}

struct Carrier: Ship {
    let length: Int = 5
    let name: String = "Carrier"
}

struct Battleship: Ship {
    let length: Int = 4
    let name: String = "Battleship"
}

struct Cruiser: Ship {
    let length: Int = 3
    let name: String = "Cruiser"
}

struct Submarine: Ship {
    let length: Int = 3
    let name: String = "Submarine"
}

struct Destroyer: Ship {
    let length: Int = 2
    let name: String = "Destroyer"
}
