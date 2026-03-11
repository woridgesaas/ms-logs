# Woridge Centralized Logging System (PLG Stack)

This service centralizes two types of logs for all microservices:

- **System Audits**: Business actions for users (e.g., invoice modification).
- **Dev Logs**: Technical traces for debugging (errors, requests, performance).

---

##  How it Works

- **Microservices**: Write JSON files into a shared Named Volume.
- **Promtail**: Scans the `/audit` and `/dev` folders inside these volumes.
- **Loki**: Indexes data with labels (service, level, job).
- **Grafana**: Visualization interface to query logs.

---

## Integration Guide for Microservices

### 1. Folder Structure
Each microservice must organize its logs into two subfolders inside its volume:

- `/app/logs/audit/` : Files named `*_audit*.json`
- `/app/logs/dev/` : Files named `*_dev*.json` 

### 2. Docker Configuration
Map your internal log folder to the shared named volume in your `docker-compose.yml`:

```yaml
services:
  your-service-name:
    volumes:
      - ms-your-service_logs:/app/logs

volumes:
  ms-your-service_logs:
    external: true
    name: ms-your-service_logs # Must match the name in the ms-logs service
```

## How to Access & Query Logs
### 1. Connect to Grafana
Access the interface: 
```http://localhost:3000 ```

Default login: 
```admin / admin.```
### 2. Configure Loki Connection
- Go to Configuration (Gear icon) > **Data Sources.**
- Click Add data source and choose **Loki.**
- In URL, enter the internal Docker address: 
```http://woridge.ms-logs.loki:3100.```
- Click Save & Test.

### 3. Explore Logs (LogQL)
Go to the Explore (Compass icon) tab and use label selectors:
- For Debugging (Dev):
``` {job="system_dev_logs", service="auth", level="Error"}```
