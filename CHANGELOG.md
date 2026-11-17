# Changelog

Each entry is one version of this template. Breaking changes are listed first.
Deployers get an "update available" notice in Railway when a change is merged to `main`. Read the entry before you apply it.

## 5.38.0 (2026-11-17)

- No breaking changes. Check history in the SQLite database on the `/data` volume and your `GATUS_CONFIG` are kept.
- Gatus [v5.38.0](https://github.com/TwiN/gatus/releases/tag/v5.38.0): Resend alerting provider, Telegram token redacted from errors, SSH keyboard-interactive auth, WebSocket timeouts and other fixes.
- Images: `twinproduction/gatus:v5.38.0@sha256:085ed63da963728965d00a3c78aa6167e3bf135218485b893201758e079e8415` and base `alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf`.

## 5.37.0 (2026-11-16)

- First release: Gatus v5.37.0 (`twinproduction/gatus:v5.37.0@sha256:094eb186e55235db367e90e9d56140e5897b7044c41de23cde4cc18e6da1242e`) with its configuration in `GATUS_CONFIG` and SQLite storage on a `/data` volume.
