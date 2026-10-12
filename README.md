# SmartLMS — Backend API

Spring Boot 3 REST API & WebSocket server for the Smart Learning Management System (SmartLMS).

## 🚀 Tech Stack
- **Framework:** Spring Boot 3.2.5 (Java 21)
- **Database:** MySQL 8.4 (Cloud-hosted on Aiven)
- **ORM:** Spring Data JPA / Hibernate (auto ddl update)
- **Security:** Spring Security + JWT Authentication (HMAC-SHA256)
- **Real-Time Messaging:** Spring WebSocket (Native `/ws/chat` + STOMP `/ws-chat`)
- **Deployment:** Render (via Dockerfile)

---

## ⚙️ Environment Variables

The backend uses the following environment variables (with pre-configured defaults for Aiven Cloud MySQL):

| Variable | Default Value | Description |
| :--- | :--- | :--- |
| `DB_HOST` | `mysql-1e3b0ced-smartlmsdatabase.j.aivencloud.com` | Aiven MySQL Host |
| `DB_PORT` | `11037` | Aiven MySQL Port |
| `DB_NAME` | `defaultdb` | Database Name |
| `DB_USERNAME` | `avnadmin` | Database User |
| `DB_PASSWORD` | *(Set in Render env vars)* | Database Password |
| `PORT` | `8008` | Server Port (auto-set by Render) |
| `CORS_ALLOWED_ORIGINS` | `http://localhost:3000,http://localhost:5173,https://*.vercel.app` | Allowed origins / patterns |
| `JWT_SECRET` | *Pre-configured 256-bit secret* | Secret key for signing JWT tokens |
| `JWT_EXPIRATION` | `86400000` (24 hours) | JWT token lifespan in milliseconds |

---

## 🛠️ Local Development

### Prerequisites
- JDK 21 installed (`java -version`)
- Maven installed (`mvn -version`)

### Run Locally
```bash
mvn clean spring-boot:run
```
The server will start at `http://localhost:8008`.
You can check health at `http://localhost:8008/api/health`.

---

## 🌐 Deploying to Render

1. Create a new repository on GitHub (e.g. `smartlms-backend`) and push the `backend` directory code to it.
2. Sign in to [Render](https://render.com/).
3. Click **New +** → **Web Service**.
4. Connect your GitHub repository (`smartlms-backend`).
5. Choose **Docker** as the Runtime (or Render will detect the `Dockerfile` automatically).
6. Under **Advanced** → **Environment Variables**, you can add or verify:
   - `CORS_ALLOWED_ORIGINS`: `http://localhost:3000,https://*.vercel.app,https://<your-vercel-app>.vercel.app`
   *(Database credentials already have defaults in `application.yml`, but you can also set them explicitly in Render for extra security).*
7. Set Health Check Path to: `/api/health`
8. Click **Deploy Web Service**.
9. Once deployed, note down your Render service URL (e.g., `https://smartlms-backend.onrender.com`).
