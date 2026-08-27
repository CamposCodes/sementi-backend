package api.sementi;

import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.springframework.context.annotation.Bean;
import org.testcontainers.postgresql.PostgreSQLContainer;
import org.testcontainers.utility.DockerImageName;

/**
 * Sobe um Postgres real para os testes, no lugar do H2.
 *
 * <p>O @ServiceConnection injeta a URL do container no datasource, entao as
 * migrations do Flyway sao executadas em todo teste e o ddl-auto=validate
 * compara as entidades contra o schema migrado de verdade.
 *
 * <p>A versao e fixa em 16 para acompanhar o Neon. Usar "latest" testaria
 * contra uma versao diferente da que roda em producao.
 */
@TestConfiguration(proxyBeanMethods = false)
class TestcontainersConfiguration {

	@Bean
	@ServiceConnection
	PostgreSQLContainer postgresContainer() {
		return new PostgreSQLContainer(DockerImageName.parse("postgres:16"));
	}

}
