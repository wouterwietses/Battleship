# Ship Sinking Detection — Evolution Record

**Date**: 2026-03-09
**Story**: Story 4 — Detect Ship Sinking
**Status**: IMPLEMENTED

## Problem

Players had no feedback when they sank an enemy ship. The tracking board showed the same hit indicator for partial hits and fully destroyed ships. Players couldn't track progress toward winning.

## Solution

When a shot hits the final unhit cell of an enemy ship, the game:
1. Returns `.sunk(shipName:)` instead of `.hit`
2. Upgrades all cells of that ship to the sunk indicator on the tracking board
3. Announces which ship was sunk and how many enemy ships remain
4. Declares victory when the last ship is sunk

## Key Design Decisions

### Ship Identity Tracking
`CellValue` changed from `.ship` to `.ship(name: String)` to associate each coordinate with its ship. `Player` maintains a `shipCoordinates` dictionary mapping ship names to their coordinate sets and a `hitCoordinates` set for sinking detection.

### ShotResult Extension
`ShotResult` gained `.sunk(shipName: String)` with `Equatable` conformance. This flows through `Player.receiveShot` → `BattleshipGame.fire` → `Player.recordShot`.

### Message Delivery
`PlayerState` protocol gained `displayMessage(_:)` for announcements. The game delivers sinking announcement, remaining count, and optional victory message through this channel.

### Tracking Board Sunk State
When a ship sinks, `BattleshipGame.fire()` upgrades all previously-recorded hit cells for that ship to `.sunk` on the attacker's tracking board, rendered as distinct from regular hits.

## Files Changed

### Production Code (8 files after refactoring)
| File | Role |
|------|------|
| `Coordinate.swift` | XAxis, YAxis, Coordinate (extracted from BattleshipBoard) |
| `Player.swift` | Player class with ship tracking and sinking detection |
| `PlayerState.swift` | Protocol + Board/TrackingBoard type aliases |
| `ShotResult.swift` | miss / hit / sunk(shipName:) enum |
| `ShipPlacer.swift` | Shared ship placement coordinate calculation |
| `Ships.swift` | Ship protocol with `name` property, 5 ship types |
| `BattleshipGame.swift` | Game orchestration, fire/sink/victory logic |
| `BattleshipBoard.swift` | Legacy board class (delegates to ShipPlacer) |

### Test Code (4 files)
| File | Tests |
|------|-------|
| `ShipSinkingTests.swift` | 7 acceptance tests (sinking, partial hit, rendering, announcements, victory, miss) |
| `MockPlayer.swift` | Added messages array, displayMessage, trackingOutput, sunk rendering |
| `BattleshipTests.swift` | Updated placement assertion for new CellValue |
| `ShotTests.swift` | Unchanged — existing tests still pass |

## Refactoring (RPP L1-L6)

| Level | Changes |
|-------|---------|
| L1 Readability | Extracted Coordinate.swift, Player.swift, PlayerState.swift, ShotResult.swift |
| L2 Complexity | Eliminated duplicated tracking board rendering in MockPlayerState |
| L3 Responsibilities | Extracted ShipPlacer.swift to share placement logic |
| L4 Abstractions | Each domain type in its own file |
| L5-L6 | No changes needed — patterns and SOLID principles already sound |

## Test Coverage

17 tests across 6 suites, all passing:
- 7 ship sinking acceptance tests (Story 4)
- 2 shot tests (Story 3)
- 2 coordinate parsing tests
- 5 board/placement tests (Stories 1-2)
- 1 API health check

## Commits

| Hash | Message |
|------|---------|
| ecbbf14 | feat: implement Story 4 - Detect Ship Sinking |
| bfa1235 | refactor(L1): extract Coordinate types into dedicated file |
| 9407b2b | refactor(L1): extract Player, ShotResult, PlayerState into Player.swift |
| 821fd17 | refactor(L2): extract shared board rendering in MockPlayerState |
| ba57de3 | refactor(L3): extract ShipPlacer to eliminate placement duplication |
| 2f35c1f | refactor(L4): extract ShotResult and PlayerState into dedicated files |
