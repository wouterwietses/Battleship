---
id: task-2
title: Place Ships on Board
status: In Progress
assignee: []
created_date: '2025-12-09 08:13'
updated_date: '2026-01-27 08:27'
labels: []
dependencies: []
ordinal: 1000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
As a player
I want to place my fleet on the board
So that I can prepare for battle
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Place 5 ships: Carrier(5), Battleship(4), Cruiser(3), Submarine(3), Destroyer(2)
- [ ] #2 Ships shown with 🚢 emoji
- [ ] #3 Validate placement (no overlaps, within bounds)
- [ ] #4 Support horizontal and vertical orientation
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
```text
Feature: Ship Placement  
Scenario: Player places a ship successfully    

Given I have an empty board    
When I place the Carrier at position A1 horizontally
Then the cells A1 through A5 display 🚢
And the ship placement is confirmed
```
<!-- SECTION:NOTES:END -->
