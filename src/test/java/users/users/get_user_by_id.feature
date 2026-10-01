@regression @users @get_user_id
Feature: Buscar Usuario por ID - GET /usuarios/{_id}

  Background:
    * url baseUrl

  Scenario: Buscar un usuario existente por su ID
    * def newUser = getRandomUser()
    Given path 'usuarios'
    And request newUser
    When method POST
    Then status 201
    * def createdId = response._id

    Given path 'usuarios', createdId
    When method GET
    Then status 200
    And match response._id == createdId
    And match response.nome == newUser.nome
    And match response.email == newUser.email

  Scenario: Buscar un usuario con ID inexistente (Negativo)
    Given path 'usuarios', '0000000000000000'
    When method GET
    Then status 400
    And match response.message contains 'encontrado'