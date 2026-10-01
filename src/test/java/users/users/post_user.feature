@regression @users @post_user
Feature: Registrar Usuario - POST /usuarios

  Background:
    * url baseUrl

  Scenario: Registro exitoso de un nuevo usuario con datos dinámicos válidos
    * def newUser = getRandomUser()
    Given path 'usuarios'
    And request newUser
    When method POST
    Then status 201
    And match response == { message: "Cadastro realizado com sucesso", _id: '#string' }

  Scenario: Validar error 400 al registrar usuario con email duplicado (Negativo)
    # 1. Creamos el usuario inicial
    * def initialUser = getRandomUser()
    Given path 'usuarios'
    And request initialUser
    When method POST
    Then status 201

    # 2. Volvemos a colocar path 'usuarios' para la segunda llamada
    Given path 'usuarios'
    And request initialUser
    When method POST
    Then status 400
    And match response.message contains 'usado'

  Scenario: Validar error 400 al enviar body vacío
    Given path 'usuarios'
    And request {}
    When method POST
    Then status 400
    And match response.nome contains 'obrigat'
    And match response.email contains 'obrigat'
    And match response.password contains 'obrigat'
    And match response.administrador contains 'obrigat'