# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
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

[Unreleased]: https://github.com/Arcensoth/challenge-buffet-noita/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/Arcensoth/challenge-buffet-noita/releases/tag/v0.1.0
