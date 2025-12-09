---
id: task-2
title: Place Ships on Board
status: To Do
assignee: []
created_date: '2025-12-09 08:13'
labels: []
dependencies: []
---

## Description

As a player
I want to place my fleet on the board
So that I can prepare for battle

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] Place 5 ships: Carrier(5), Battleship(4), Cruiser(3), Submarine(3), Destroyer(2)
- [ ] Ships shown with 🚢 emoji
- [ ] Validate placement (no overlaps, within bounds)
- [ ] Support horizontal and vertical orientation
<!-- AC:END -->

## Implementation Notes

```text
Feature: Ship Placement  
Scenario: Player places a ship successfully    

Given I have an empty board    
When I place the Carrier at position A1 horizontally
Then the cells A1 through A5 display 🚢
And the ship placement is confirmed
```
