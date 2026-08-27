@regression @users @delete_user
Feature: Eliminar Usuario - DELETE /usuarios/{_id}

  Background:
    * url baseUrl

  Scenario: Eliminar un usuario existente exitosamente
    # Precondición: Crear usuario a eliminar
    * def user = getRandomUser()
    Given path 'usuarios'
    And request user
    When method POST
    Then status 201
    * def userId = response._id

    # Prueba: Eliminar
    Given path 'usuarios', userId
    When method DELETE
    Then status 200
    And match response.message == "Registro excluído com sucesso"

  Scenario: Intentar eliminar un usuario que no existe (Idempotencia)
    Given path 'usuarios', 'ID_INEXISTENTE_999999'
    When method DELETE
    Then status 200
    And match response.message == "Nenhum registro excluído"