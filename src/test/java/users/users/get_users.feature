@regression @users @get_users
Feature: Consulta de Usuarios - GET /usuarios

  Background:
    * url baseUrl
    * path 'usuarios'

  Scenario: Listar todos los usuarios y validar el contrato/esquema JSON
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#[_ > 0]'

    * def userSchema =
    """
    {
      "nome": '#string',
      "email": '#string',
      "password": '#string',
      "administrador": '#regex ^(true|false)$',
      "_id": '#string'
    }
    """
    And match response.usuarios[0] == userSchema

  Scenario: Filtrar usuarios administradores por query param
    Given param administrador = 'true'
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match each response.usuarios contains { administrador: 'true' }