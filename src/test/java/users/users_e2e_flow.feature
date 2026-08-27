@e2e @smoke
Feature: Flujo Integral E2E del Ciclo de Vida del Usuario (CRUD Completo)

  Background:
    * url baseUrl

  Scenario: Validar ciclo de vida completo de un usuario (Create -> Read -> Update -> Delete -> Verify)
    # 1. CREATE (POST)
    * def originalUser = getRandomUser()
    Given path 'usuarios'
    And request originalUser
    When method POST
    Then status 201
    * def userId = response._id

    # 2. READ (GET by ID)
    Given path 'usuarios', userId
    When method GET
    Then status 200
    And match response.email == originalUser.email

    # 3. UPDATE (PUT)
    * def modifiedData = getRandomUser()
    * set modifiedData.nome = "Usuario Actualizado E2E"
    Given path 'usuarios', userId
    And request modifiedData
    When method PUT
    Then status 200
    And match response.message == "Registro alterado com sucesso"

    # 4. DELETE (DELETE)
    Given path 'usuarios', userId
    When method DELETE
    Then status 200
    And match response.message == "Registro excluído com sucesso"

    # 5. VERIFY DELETION (GET by ID debe retornar 400)
    Given path 'usuarios', userId
    When method GET
    Then status 400
    And match response.message == "Usuário não encontrado"