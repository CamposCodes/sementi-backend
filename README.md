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
        ├──▶ PR para develop        ← homologação
        │      │
        │      validado em develop e nos ambientes de preview
        │      │
        └──────┴──▶ PR para main    ← a MESMA branch, agora aprovada
```

- **`main`** — produção e branch padrão. PR obrigatório, check `build` verde obrigatório, sem force-push, sem deleção.
- **`develop`** — homologação. Protegida contra deleção e force-push; não exige PR, mas o trabalho chega nela por PR.
- **`feat/*`, `fix/*`, `chore/*`** — saem de `main` e abrem **duas PRs**: primeiro para `develop`, depois para `main`.

A branch é a unidade que viaja. `develop` valida, não promove — **nunca há PR de `develop` para `main`**. Assim cada PR que chega em produção contém uma tarefa só, em vez de tudo que se acumulou em homologação.

Por isso `delete_branch_on_merge` está **desligado** nos dois repositórios: a branch precisa sobreviver ao merge em `develop` para servir à PR de `main`. Apagar depois do segundo merge, na mão.

Sair de `main` e não de `develop` é deliberado: a branch nasce do que está em produção, então a PR de promoção não carrega surpresa acumulada.

Não é git-flow clássico — não existe `release/*` nem `hotfix/*`.
