# Honey API Playground Integration Tests

This project contains the integration tests for [Honey API Playground](https://github.com/MichaelToningerPolidoro/honey-api-playground). The test suite sends HTTP requests to a real API instance and validates status codes, response bodies, authentication, validation rules, and complete user flows.

The API project documents the available features and endpoints. This README complements that documentation by explaining how to run and maintain the automated tests.

## Objectives

The tests were created to:

- validate the integration between the API components through HTTP requests;
- verify user registration, login, retrieval, update, and deletion flows;
- cover successful and invalid-data scenarios;
- validate HTTP Basic authentication and JWT token usage;
- test the country, hobby, and programming-time reference resources;
- detect regressions in the documented API behavior.

## Main Technologies and tools

- Java 24 — Primary programming language.
- Cucumber 8 — Used to define test scenarios in Gherkin.
- JUnit Platform Suite 6 — Configure and organize test execution through test suites. 
- REST Assured — Build HTTP requests and validate REST API responses. 
- JsonPath — Used to manipulate data during requests. 
- Maven — Used for dependency management, build configuration, and test execution. 
- OpenAI Codex — Used as an AI-assisted development.

## Prerequisites

Before running the tests, you must:

1. Install JDK 24 and Maven.
2. Clone and start the [Honey API Playground](https://github.com/MichaelToningerPolidoro/honey-api-playground) project.
3. Make sure the API is available at `http://localhost:8080`.
4. Find the values for the `username` and `password` variables in the [HTTP Basic Authentication section of the API documentation](https://github.com/MichaelToningerPolidoro/honey-api-playground/blob/main/docs/api.md#http-basic-authentication).

The tests currently use the local URL `http://localhost:8080` directly in the `.feature` files.

## Running the tests

To run the regression test suite:

```bash
mvn test -Dcucumber.filter.tags="@regression"
```

The test suite can be filtered using Cucumber tag expressions.

| Tag | What it validates |
| --- | --- |
| `@regression` | Groups the regression scenarios that validate the API's expected behavior. |
| `@endToEnd` | Validates the complete user lifecycle: registration, authentication, retrieval, update, and deletion. |
| `@referenceData` | Validates the retrieval of countries, hobbies, and programming-time options. |
| `@invalidData` | Groups scenarios that validate invalid, missing, duplicated, or out-of-range data. |
| `@invalidDataRegister` | Validates invalid data and business rules during user registration. |
| `@invalidDataLogin` | Validates invalid credentials and login payload validation. |
| `@invalidDataGet` | Validates unauthorized requests and retrieval of non-existent users. |
| `@invalidDataUpdate` | Validates authentication, relationships, and invalid data during user updates. |
| `@invalidDataDelete` | Validates unauthorized deletion requests and deletion of non-existent users. |
| `@contract` / `@schema` | Validates response structures using JSON Schema. |

## Scenario coverage

The scenarios are organized by purpose:

| Directory/file | Coverage |
| --- | --- |
| `features/end_to_end/UserLifecycle.feature` | Complete user lifecycle: registration, authentication, retrieval, update, and deletion |
| `features/reference_data/ReferenceData.feature` | Retrieval of countries, hobbies, and programming-time options |
| `features/invalid_data/Register.feature` | Registration with missing, invalid, duplicated, or out-of-range data |
| `features/invalid_data/Login.feature` | Login with a non-existent user, incorrect password, and invalid payload data |
| `features/invalid_data/Get.feature` | Retrieval with an invalid token or a non-existent user |
| `features/invalid_data/Update.feature` | Update with authentication, relationships, and invalid data |
| `features/invalid_data/Delete.feature` | Deletion of non-existent users and unauthorized requests |
| `features/schemas/ResponseSchemas.feature` | Contract validation for login, user, and validation-error responses |

The JSON files in `src/test/resources/request/body` serve as request templates. Scenarios can replace specific fields during execution to generate isolated and reproducible data.

## Project structure

```text
src/
├── main/
│   ├── java/com/honey/apiplayground/
│   │   ├── config/       # Environment and parallelism strategies
│   │   ├── context/      # Data shared during a scenario
│   │   ├── handlers/     # Request and response preparation
│   │   ├── hooks/        # Configuration before and after scenarios
│   │   ├── managers/     # REST Assured specification management
│   │   ├── steps/        # Reusable Cucumber steps
│   │   └── utils/        # File reading and utilities
│   └── resources/
│       └── junit-platform.properties
└── test/
    ├── java/             # Runner and test-specific providers
    └── resources/
        ├── features/     # BDD scenarios
        └── request/      # JSON bodies and schemas
```

## Environment variables

The following environment variables can be used to configure the tests:

| Variable | Required | Description | Default |
| --- | --- | --- | --- |
| `username` | Yes | Username used for HTTP Basic authentication. The local value is available in the [API documentation](https://github.com/MichaelToningerPolidoro/honey-api-playground/blob/main/docs/api.md#http-basic-authentication). | — |
| `password` | Yes | Password used for HTTP Basic authentication. The local value is available in the [API documentation](https://github.com/MichaelToningerPolidoro/honey-api-playground/blob/main/docs/api.md#http-basic-authentication). | — |
| `parallel_scenarios_count` | No | Number of scenarios to execute in parallel. | `1` |
| `cache_request_bodies` | No | Enables the JSON request body cache when set to `true`. | `false` |

PowerShell example:

```powershell
$env:username = "your-username"
$env:password = "your-password"
$env:parallel_scenarios_count = "4"
$env:cache_request_bodies = "true"
```

Cucumber is configured to support parallel execution. The body cache remains disabled by default.

## Reports and evidence

In addition to the terminal output, the runner is configured to generate a Cucumber HTML report at:

```text
src/test/resources/evidences/cucumber-html-report.html
```

Requests and responses are automatically logged when a validation fails, making it easier to investigate broken scenarios.

## Relationship with the API documentation

To understand the endpoints, models, response codes, and business rules covered by the tests, see the main project's documentation:

- [Honey API Playground README](https://github.com/MichaelToningerPolidoro/honey-api-playground)
- [API documentation](https://github.com/MichaelToningerPolidoro/honey-api-playground/blob/main/docs/api.md)
- [Configuration documentation](https://github.com/MichaelToningerPolidoro/honey-api-playground/blob/main/docs/configuration.md)

## License

This project is licensed under the terms described in the [LICENSE](LICENSE) file.
