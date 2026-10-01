Feature: Autenticación en ServeRest API

  Background:
    * url baseUrl = 'https://serverest.dev'

  Scenario: Inicio de sesión exitoso y obtención de token
    Given path '/login'
    And request { email: 'fulano@qa.com', password: 'teste' }
    When method post
    Then status 200
    And match response.message == 'Login realizado com sucesso'
    And match response.authorization != null
    * def authToken = response.authorization
    * print 'Token obtenido exitosamente:', authToken

  Scenario: Inicio de sesión fallido con contraseña incorrecta
    Given path '/login'
    And request { email: 'fulano@qa.com', password: 'clave_invalida' }
    When method post
    Then status 401
    And match response.message == 'Email e/ou senha inválidos'