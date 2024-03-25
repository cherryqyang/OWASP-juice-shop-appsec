```mermaid
graph TD

    subgraph Angular_Client["Angular Client"]
        Services["Services (e.g., API calls)"]
        Components["Components (e.g., UI elements)"]
        Interceptors["Interceptors (e.g., auth handling)"]
        Models["Models (e.g., data structures)"]
        Services -->|uses| Components
        Interceptors -->|modifies| Services
        Services -->|updates| Models
        Models -->|defines| Components
    end

    subgraph NodeJS_Server["Node.js/Express Server"]
        Routes["Routes (e.g., API endpoints)"]
        Middleware["Middleware (e.g., security, logging)"]
        Controllers["Controllers (e.g., business logic)"]
        Models_Server["Models (e.g., database access)"]
        Routes -->|utilizes| Middleware
        Middleware -->|controls| Controllers
        Controllers -->|interacts with| Models_Server
    end

    Angular_Client -->|interacts with| NodeJS_Server

    style Angular_Client fill:#f9f,stroke:#333,stroke-width:2px
    style NodeJS_Server fill:#ccf,stroke:#333,stroke-width:2px
