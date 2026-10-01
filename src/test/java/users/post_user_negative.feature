Feature: Validaciones negativas al registrar usuarios

  Background:
    * url baseUrl = 'https://serverest.dev'

  Scenario: Intentar registrar un usuario con un email que ya existe
    # 1. Primer intento (o usuario fijo ya existente)
    Given path '/usuarios'
    And request
      """
      {
        "nome": "Usuario Existente",
        "email": "fulano@qa.com",
        "password": "teste",
        "administrador": "true"
      }
      """
    When method post
    # Si ya existe, debe responder 400 Bad Request
    Then status 400
    And match response.message == "Este email já está sendo usado"