# Changelog

All notable changes to this repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Public-scope guard workflow and verification script for PRs to `main`.
- Dependency profiles: `requirements-core.txt`, `requirements-ml.txt`, `requirements-ui.txt`.
- Trust pages for enterprise buyer path, evidence samples, and engagement analytics.
- Engagement KPI catalog and monthly baseline template.

### Changed
- Security CI now audits Python profiles, generates Python license reports, and runs npm audit for `frontend/ux-prototype`.
- CI Python/Frontend default installs now use lightweight dependency profiles.
- Sector pages now share a committee-ready operating standard format.

## [0.1.0] - 2026-02-16

### Added
- Public baseline release tag `v0.1.0`.
- Initial CI, docs, and governance baseline for public repository.
