# Deploy and Host Gatus on Railway

Gatus is a developer-oriented health dashboard and status page. It checks HTTP, TCP, ICMP, DNS, TLS certificates and more on a schedule, evaluates conditions such as status codes, response times and JSON body values, and sends alerts to Slack, Discord, PagerDuty, Telegram, email and many other channels.

## About Hosting Gatus

This template deploys Gatus v5.37.0 from a small public wrapper image that runs the official binary as a non-root user. The whole configuration lives in the `GATUS_CONFIG` variable, so you can edit monitored endpoints and alerts in the Railway dashboard and redeploy. Gatus expands `${VAR}` references inside the config, which keeps webhook URLs and tokens in their own variables. Results are stored in SQLite on a Railway volume, so uptime history survives redeploys. The status page is public by design. Gatus is tiny and fits the Hobby plan. Alerts can go to Slack, Discord, PagerDuty, email and many other providers.

## Common Use Cases

- A public status page for your APIs and websites
- Monitoring response times, certificates and JSON health endpoints
- Alerting to Slack, Discord or PagerDuty when a service degrades

## Dependencies for Gatus Hosting

- `aalfath/gatus-railway-template` (public wrapper around `twinproduction/gatus:v5.37.0`)
- A Railway volume at `/data` for the SQLite history

### Deployment Dependencies

- [Gatus documentation](https://gatus.io/docs)
- [Gatus v5.37.0 release](https://github.com/TwiN/gatus/releases/tag/v5.37.0)
- [Wrapper repository](https://github.com/aalfath/gatus-railway-template)
- [Railway volumes](https://docs.railway.com/reference/volumes)

### Implementation Details

| Service | Source | Networking | Storage |
| --- | --- | --- | --- |
| gatus | `aalfath/gatus-railway-template` | public domain on 8080; private IPv4/IPv6 | volume at `/data` |

Add an endpoint to `GATUS_CONFIG`:

```yaml
endpoints:
  - name: API
    url: 'https://api.example.com/health'
    interval: 1m
    conditions:
      - '[STATUS] == 200'
      - '[RESPONSE_TIME] < 500'
```

| Variable | Default | Purpose |
| --- | --- | --- |
| `GATUS_CONFIG` | example config | Complete `config.yaml` |
| `PORT` | `8080` | Listening port, referenced in the config |

Notes:

- Keep `web.address: '[::]'` and the SQLite storage block when replacing the config.
- Use single quotes in the YAML; double quotes break the variable when pasted into the Railway editor.

This is a community-maintained deployment package and does not imply affiliation with or endorsement by the Gatus project or its maintainers.

## Why Deploy Gatus on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Gatus on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
