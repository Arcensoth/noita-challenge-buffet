# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Simplified Bane of Midas to fix several bugs (fixes #2 and #3)
  - A (for better or for worse) side-effect of this change is that a single gold pixel will once again kill the player

## [0.3.0] - 2021-10-26

### Changed

- The mod is no longer a game mode and can be used alongside other mods
- Curses are now custom items instead of perks (fixes #1)
- Curses now show translated names/descriptions like perks
- Adjusted some animations and cosmetic effects

## [0.2.0] - 2020-09-12

### Changed

- Updated sprites for Heartbreak, Mortality, and Bane of Midas
- Mortality now damages max HP directly, instead of syncing it with HP
  - In other words: the difference between HP and max HP will be maintained
  - This means that healing by increasing max HP is intended, however difficult

### Fixed

- Fixed Mortality not synchronizing max HP cap to max HP when Heartbreak is also present

## [0.1.0] - 2020-09-12

### Added

- Added 3 unique challenges in the form of "cursed" perks
  - Heartbreak: maximum health cannot be increased
  - Bane of Midas: gold is deadly and must be avoided
  - Mortality: take damage to maximum health

[unreleased]: https://github.com/Arcensoth/challenge-buffet-noita/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/Arcensoth/challenge-buffet-noita/releases/tag/v0.2.0...v0.3.0
[0.2.0]: https://github.com/Arcensoth/challenge-buffet-noita/releases/tag/v0.1.0...v0.2.0
[0.1.0]: https://github.com/Arcensoth/challenge-buffet-noita/releases/tag/v0.1.0
