# Auth Service

Este README documenta os passos necessários para configurar e executar o `auth_service`.

### Versão do Ruby

- `3.1.6`

### Dependências do Sistema

- Certifique-se de ter o Docker e o Docker Compose instalados em sua máquina.

### Configuração

1. Clone o repositório `auth_service`:

```bash
git clone https://github.com/Raphaelbsi/auth_service.git
cd auth_service
```

2. Construa e execute os contêineres Docker:

```bash
docker-compose up --build
```

3. Execute as migrações e popule o banco de dados:

```bash
 docker-compose exec auth_service bundle exec rails db:create db:migrate db:seed
```

4. Execute a suíte de testes:

```bash
docker-compose exec auth_service bundle exec rspec
```

### Documentação da API

Endpoints de Usuário

- Registrar Usuário
  - URL: /register
  - Método: POST
  - Corpo:

```json
{
  "user": {
    "email": "teste@example.com",
    "password": "password",
    "password_confirmation": "password",
    "name": "Sr Teste"
  }
}
```

- Resposta:

```json
{
  "status": "User created successfully"
}
```

- Login de Usuário
  - URL: /login
  - Método: POST
  - Corpo:

```json
{
  "email": "john@example.com",
  "password": "password"
}
```

- Resposta:

```json
{
  "token": "jwt_token"
}
```

- Validar Token
  - URL: /verify
  - Método: GET
    - Parâmetros de Consulta:
      - token: Token JWT

```json
{
  "user_id": 1
}
```

## Exemplo de Comandos CURL

- Register

```bash
curl --location 'http://localhost:3001/register' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user": {
        "email": "teste@example.com",
        "password": "password",
        "password_confirmation": "password",
        "name": "Sr Teste"
    }
}'
```

- Login

```bash
curl --location 'http://localhost:3001/login' \
--header 'Content-Type: application/json' \
--data-raw '{
  "email": "test@example.com",
  "password": "password"
}'
```

- Verify

```bash
curl --location --request GET 'http://localhost:3001/verify' \
--header 'Content-Type: application/json' \
--data '{"token": "Seu Token"}'
```
