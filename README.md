# sementi-backend

API do Sementi — app de vocabulário diário.

**Stack:** Java + Spring Boot, Gradle, Spring Data JPA, Spring Security + OAuth2 (Google), PostgreSQL

**Status:** em desenvolvimento (Fase 0 — setup)

## Branches

```
main (produção)
  │
  └── feat/xxx  ou  fix/xxx        ← sai SEMPRE de main
        │
        merge direto em develop     ← homologação, sem PR
        │
        validado em develop e nos ambientes de preview
        │
        └──▶ PR de develop para main   ← a única PR do ciclo
```

- **`main`** — produção e branch padrão. PR obrigatório, check `build` verde obrigatório, sem force-push, sem deleção.
- **`develop`** — homologação. Aceita push direto; protegida apenas contra deleção e force-push.
- **`feat/*`, `fix/*`, `chore/*`** — saem de `main` e são mergeadas direto em `develop`, sem PR. Apagar manualmente depois do merge.

Existe uma PR por ciclo, e ela é a de `develop` para `main`. É lá que o CI e o review incidem, sobre trabalho já validado em homologação e no preview — não sobre código recém-escrito.

Sair de `main` e não de `develop` é deliberado: a branch nasce do que está em produção, então a PR de promoção não carrega surpresa acumulada.

Não é git-flow clássico — não existe `release/*` nem `hotfix/*`.
