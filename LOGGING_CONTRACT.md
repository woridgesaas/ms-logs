# 📘 Audit Logging Contract 

This document defines the **audit logging contract** to ensure multi-tenant traceability within our microservices architecture.

Every important business action must generate an audit log

---

## 🏆 Golden Rules

### 1️⃣ Tagging

Every audit log **must include** the following property:

```json
{
  "LogType": "Audit"
}
````
### 2️⃣ JSON Structure
Audit logs must use structured logging format exclusively

### 3️⃣ Storage Location
Audit logs must be written to:
```json
/app/logs/audit/
````
This directory is collected by Promtail.

---

## 🔑 Audit Properties Contract
| Property        | Description                  | Example               |
| --------------- | ---------------------------- | --------------------- |
| `TenantId`      | Client subdomain             | `client-alpha`        |
| `UserMatricule` | Unique user identifier / CIN | `ZH1234`              |
| `UserRole`      | User role                    | `Admin`               |
| `Action`        | Operation name in uppercase  | `OFFER_CREATED`       |
| `Target`      | Impacted entity identifier /Module   | `AuthService`          |
| `Status`        | Operation result             | `Success` / `Failure` |


### Message Template
The audit message must follow this exact template:
```json
Audit: {Action} performed by {UserMatricule} on {TargetId} [Status: {Status}]
````
### Exemple of generated audit log
```json
{
  "Timestamp": "2026-02-14T10:15:32.456Z",
  "Level": "Information",
  "MessageTemplate": "Audit: {Action} performed by {UserMatricule} on {TargetId} [Status: {Status}]",
  "Properties": {
    "LogType": "Audit",
    "TenantId": "client-alpha",
    "UserMatricule": "ZH1234",
    "UserRole": "Admin",
    "Action": "CONTRACT_SIGNED",
    "TargetId": "Administratif-Documents",
    "Status": "Success"
  }
}
