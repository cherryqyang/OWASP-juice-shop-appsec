```mermaid
graph TD

    subgraph Angular_Client["Angular Client"]
        Services["Services (e.g., API calls - <br>frontend/src/app/services)"]
        Components["Components (e.g., UI elements -<br> frontend/src/app/components)"]
        Interceptors["Interceptors (e.g., request.interceptor.ts - <br>frontend/src/app/services or <br>frontend/src/app/interceptors)"]
        Models["Models (e.g., data structures - <br>frontend/src/app/models)"]
        Services -->|uses| Components
        Interceptors -->|modifies| Services
        Services -->|updates| Models
        Models -->|defines| Components
    end

    subgraph NodeJS_Server["Node.js/Express Server"]
        Routes["Routes (e.g., API endpoints - <br>backend/routes)"]
        Middleware["Middleware (e.g., security, logging - <br>backend/middleware)"]
        Controllers["Controllers (e.g., business logic - <br>backend/controllers)"]
        Models_Server["Models (e.g., database access - <br>backend/models)"]
        Routes -->|utilizes| Middleware
        Middleware -->|controls| Controllers
        Controllers -->|interacts with| Models_Server
    end

    Angular_Client -->|interacts with| NodeJS_Server

    style Angular_Client fill:#f9f,stroke:#333,stroke-width:2px
    style NodeJS_Server fill:#ccf,stroke:#333,stroke-width:2px

