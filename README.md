# sementi-backend

API do Sementi — app de vocabulário diário.

**Stack:** Java + Spring Boot, Gradle, Spring Data JPA, Spring Security + OAuth2 (Google), PostgreSQL

**Status:** em desenvolvimento (Fase 0 — setup)

## Branches

- `main` — produção. Branch padrão. Só recebe `release/*` e `hotfix/*` via PR.
- `develop` — integração. Base de todo trabalho novo.
- `feature/*` — sai de `develop`, volta pra `develop`.
- `release/*` e `hotfix/*` — criadas sob demanda, únicas que chegam em `main`.
