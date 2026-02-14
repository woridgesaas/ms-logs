# Woridge Centralized Logging System

This service centralizes audits from all microservices using Loki and Promtail.

## 🚀 How it Works

1. Microservices write audit logs into a shared Named Volume
2. Promtail scans the volume and pushes logs to Loki
3. Loki indexes the data for querying

## 🛠️ Integration Guide for Microservices

Every microservice (Auth, Conge, etc.) must implement the following:

### 1. Docker Configuration

Map your internal log folder to the shared external volume in `docker-compose.yml`:

```yaml
services:
  your-service-name:
    volumes:
      - auth_logs:/app/logs # Map internal path to the shared volume

volumes:
  auth_logs:
    external: true
    name: auth_logs # Must match the volume name in ms-logs
```

### 2.Querying Logs exemple(LogQL)
```http://localhost:3100/loki/api/v1/query_range?query={job="system_audits"}```

| Requirement | LogQL Query |
|-------------|-------------|
| All Logs | `{job="system_audits"}` |
| Parse Fields | `{job="system_audits"} \| json` |
| By User | `{job="system_audits"} \| json \| user="Zakariyae"` |
| By Action | `{job="system_audits"} \| json \| action="LOGIN"` |
| By Status | `{job="system_audits"} \| json \| status="FAILED"` |