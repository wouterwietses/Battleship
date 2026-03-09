---
id: task-4
title: 'Story 4: Detect Ship Sinking'
status: Done
assignee: []
created_date: '2026-03-09 17:00'
updated_date: '2026-03-09 17:00'
labels: []
dependencies: [task-3]
ordinal: 1000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
As a player I want to know when I've sunk an enemy ship So that I can track my progress
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Track hits on each ship
- [x] #2 Display 🔥 for sunk ship cells
- [x] #3 Announce ship name when sunk
- [x] #4 Show remaining enemy ships count
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Feature: Ship Sinking Detection
Scenario: Player sinks enemy destroyer

Given the enemy has a Destroyer at C3-C4
And I have hit C3
When I fire at C4
Then both C3 and C4 show 🔥
And I see "You sank the enemy Destroyer!"
<!-- SECTION:NOTES:END -->
