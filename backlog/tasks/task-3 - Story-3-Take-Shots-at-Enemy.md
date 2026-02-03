---
id: task-3
title: 'Story 3: Take Shots at Enemy'
status: In Progress
assignee: []
created_date: '2026-02-03 08:04'
updated_date: '2026-02-03 08:04'
labels: []
dependencies: []
ordinal: 1000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
As a player I want to fire at coordinates on the enemy board So that I can try to sink their ships
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Input coordinates to fire (e.g., "B5")
- [ ] #2 Show miss with ❌ emoji
- [ ] #3 Show hit with 💥 emoji
- [ ] #4 Display both my board and tracking board
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Feature: Firing Shots  
Scenario: Player fires and misses    

Given the game has started with all ships placed
When I fire at coordinate B5    
Then the tracking board shows ❌ at B5 
And I receive feedback "Miss!"

Feature: Firing Shots  
Scenario: Player fires and hits    

Given the game has started with all ships placed
And one of the ship has a piece place on B5
When I fire at coordinate B5    
Then the tracking board shows &#x1f4a5; at B5 
And I receive feedback "Hit!"
<!-- SECTION:NOTES:END -->
