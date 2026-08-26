# syntax=docker/dockerfile:1

# O Render nao tem runtime nativo de Java (so Node, Python, Ruby, Go,
# Rust e Elixir), entao aplicacao JVM la exige Docker.
# https://render.com/docs/native-runtimes

# ---------- build ----------
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Wrapper e arquivos de build antes do src/: mudanca em codigo nao
# invalida a camada de download de dependencia.
COPY gradlew ./
COPY gradle ./gradle
COPY settings.gradle build.gradle ./
RUN chmod +x gradlew && ./gradlew --no-daemon dependencies

COPY src ./src
# Sem teste aqui de proposito: o CI ja roda ./gradlew build com testes
# em todo PR. Repetir no build da imagem so deixa o deploy lento e cria
# uma segunda chance de falhar por motivo nao relacionado ao deploy.
RUN ./gradlew --no-daemon bootJar -x test

# ---------- runtime ----------
# JRE alpine em vez de JDK: imagem menor. Importa mais do que o normal
# aqui, porque o free tier do Render dorme com ~15 min ocioso e o
# tamanho da imagem entra direto no tempo de acordar.
FROM eclipse-temurin:21-jre-alpine AS runtime
WORKDIR /app

RUN addgroup -S sementi && adduser -S sementi -G sementi
USER sementi

COPY --from=build --chown=sementi:sementi /app/build/libs/app.jar app.jar

# MaxRAMPercentage faz a JVM calcular o heap pelo limite do container.
# Sem isso ela calcula pela memoria do host e estoura os 512 MB do
# free tier do Render.
ENV JAVA_OPTS="-XX:MaxRAMPercentage=75"

EXPOSE 8080

# sh -c com exec: mantem o java como PID 1 (sinal de shutdown chega
# certo) e ainda permite sobrescrever JAVA_OPTS pelo painel do Render
# sem precisar rebuildar a imagem.
ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar app.jar"]
