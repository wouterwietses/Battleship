@testable import Battleship

final class MockPlayerState: PlayerState {
    private var name: String?
    private var board: Board?
    private var trackingBoard: TrackingBoard?
    private(set) var messages: [String] = []

    func currentState(name: String, board: Board, trackingBoard: TrackingBoard) {
        self.name = name
        self.board = board
        self.trackingBoard = trackingBoard
    }

    func displayMessage(_ message: String) {
        messages.append(message)
    }

    var output: String {
        let raw = """
        Trackingboard
            A  B  C  D  E  F  G  H  I  J
        \(trackingRow(1, .A1, .B1, .C1, .D1, .E1, .F1, .G1, .H1, .I1, .J1))
        \(trackingRow(2, .A2, .B2, .C2, .D2, .E2, .F2, .G2, .H2, .I2, .J2))
        \(trackingRow(3, .A3, .B3, .C3, .D3, .E3, .F3, .G3, .H3, .I3, .J3))
        \(trackingRow(4, .A4, .B4, .C4, .D4, .E4, .F4, .G4, .H4, .I4, .J4))
        \(trackingRow(5, .A5, .B5, .C5, .D5, .E5, .F5, .G5, .H5, .I5, .J5))
        \(trackingRow(6, .A6, .B6, .C6, .D6, .E6, .F6, .G6, .H6, .I6, .J6))
        \(trackingRow(7, .A7, .B7, .C7, .D7, .E7, .F7, .G7, .H7, .I7, .J7))
        \(trackingRow(8, .A8, .B8, .C8, .D8, .E8, .F8, .G8, .H8, .I8, .J8))
        \(trackingRow(9, .A9, .B9, .C9, .D9, .E9, .F9, .G9, .H9, .I9, .J9))
        \(trackingRow(10, .A10, .B10, .C10, .D10, .E10, .F10, .G10, .H10, .I10, .J10))

        \(name ?? "Unknown Player")
            A  B  C  D  E  F  G  H  I  J
        1  \(icon(.A1)) \(icon(.B1)) \(icon(.C1)) \(icon(.D1)) \(icon(.E1)) \(icon(.F1)) \(icon(.G1)) \(icon(.H1)) \(icon(.I1)) \(icon(.J1))
        2  \(icon(.A2)) \(icon(.B2)) \(icon(.C2)) \(icon(.D2)) \(icon(.E2)) \(icon(.F2)) \(icon(.G2)) \(icon(.H2)) \(icon(.I2)) \(icon(.J2))
        3  \(icon(.A3)) \(icon(.B3)) \(icon(.C3)) \(icon(.D3)) \(icon(.E3)) \(icon(.F3)) \(icon(.G3)) \(icon(.H3)) \(icon(.I3)) \(icon(.J3))
        4  \(icon(.A4)) \(icon(.B4)) \(icon(.C4)) \(icon(.D4)) \(icon(.E4)) \(icon(.F4)) \(icon(.G4)) \(icon(.H4)) \(icon(.I4)) \(icon(.J4))
        5  \(icon(.A5)) \(icon(.B5)) \(icon(.C5)) \(icon(.D5)) \(icon(.E5)) \(icon(.F5)) \(icon(.G5)) \(icon(.H5)) \(icon(.I5)) \(icon(.J5))
        6  \(icon(.A6)) \(icon(.B6)) \(icon(.C6)) \(icon(.D6)) \(icon(.E6)) \(icon(.F6)) \(icon(.G6)) \(icon(.H6)) \(icon(.I6)) \(icon(.J6))
        7  \(icon(.A7)) \(icon(.B7)) \(icon(.C7)) \(icon(.D7)) \(icon(.E7)) \(icon(.F7)) \(icon(.G7)) \(icon(.H7)) \(icon(.I7)) \(icon(.J7))
        8  \(icon(.A8)) \(icon(.B8)) \(icon(.C8)) \(icon(.D8)) \(icon(.E8)) \(icon(.F8)) \(icon(.G8)) \(icon(.H8)) \(icon(.I8)) \(icon(.J8))
        9  \(icon(.A9)) \(icon(.B9)) \(icon(.C9)) \(icon(.D9)) \(icon(.E9)) \(icon(.F9)) \(icon(.G9)) \(icon(.H9)) \(icon(.I9)) \(icon(.J9))
        10 \(icon(.A10)) \(icon(.B10)) \(icon(.C10)) \(icon(.D10)) \(icon(.E10)) \(icon(.F10)) \(icon(.G10)) \(icon(.H10)) \(icon(.I10)) \(icon(.J10))
        """
        return raw.split(separator: "\n", omittingEmptySubsequences: false)
            .map { line in
                var trimmed = String(line)
                while trimmed.hasSuffix(" ") {
                    trimmed.removeLast()
                }
                return trimmed
            }
            .joined(separator: "\n")
    }

    var trackingOutput: String {
        let raw = """
        Trackingboard
            A  B  C  D  E  F  G  H  I  J
        \(trackingRow(1, .A1, .B1, .C1, .D1, .E1, .F1, .G1, .H1, .I1, .J1))
        \(trackingRow(2, .A2, .B2, .C2, .D2, .E2, .F2, .G2, .H2, .I2, .J2))
        \(trackingRow(3, .A3, .B3, .C3, .D3, .E3, .F3, .G3, .H3, .I3, .J3))
        \(trackingRow(4, .A4, .B4, .C4, .D4, .E4, .F4, .G4, .H4, .I4, .J4))
        \(trackingRow(5, .A5, .B5, .C5, .D5, .E5, .F5, .G5, .H5, .I5, .J5))
        \(trackingRow(6, .A6, .B6, .C6, .D6, .E6, .F6, .G6, .H6, .I6, .J6))
        \(trackingRow(7, .A7, .B7, .C7, .D7, .E7, .F7, .G7, .H7, .I7, .J7))
        \(trackingRow(8, .A8, .B8, .C8, .D8, .E8, .F8, .G8, .H8, .I8, .J8))
        \(trackingRow(9, .A9, .B9, .C9, .D9, .E9, .F9, .G9, .H9, .I9, .J9))
        \(trackingRow(10, .A10, .B10, .C10, .D10, .E10, .F10, .G10, .H10, .I10, .J10))
        """
        return raw.split(separator: "\n", omittingEmptySubsequences: false)
            .map { line in
                var trimmed = String(line)
                while trimmed.hasSuffix(" ") {
                    trimmed.removeLast()
                }
                return trimmed
            }
            .joined(separator: "\n")
    }

    private func trackingRow(_ row: Int, _ coords: Coordinate...) -> String {
        let prefix = row < 10 ? "\(row)  " : "\(row) "
        let cells = coords.map { trackingIcon($0) }.joined(separator: " ")
        return prefix + cells
    }

    private func icon(_ coordinate: Coordinate) -> String {
        guard let cellValue = board?[coordinate] else {
            return "🌊"
        }

        switch cellValue {
        case .water:
            return "🌊"
        case .ship:
            return "🚢"
        }
    }

    private func trackingIcon(_ coordinate: Coordinate) -> String {
        guard let shotResult = trackingBoard?[coordinate] else {
            return "  "
        }

        switch shotResult {
        case .miss:
            return "❌"
        case .hit:
            return "💥"
        case .sunk:
            return "🔥"
        }
    }
}
