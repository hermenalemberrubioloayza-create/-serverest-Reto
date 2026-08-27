@regression @users @put_user
Feature: Actualización de Usuarios - PUT /usuarios/{_id}

  Background:
    * url baseUrl

  Scenario: Actualizar los datos de un usuario existente exitosamente
    # Precondición: Crear usuario
    * def user = getRandomUser()
    Given path 'usuarios'
    And request user
    When method POST
    Then status 201
    * def userId = response._id

    # Actualizar datos
    * def updatedUser = getRandomUser()
    * set updatedUser.nome = "Nombre Modificado QA"

    Given path 'usuarios', userId
    And request updatedUser
    When method PUT
    Then status 200
    And match response == { "message": "Registro alterado com sucesso" }

  Scenario: Crear un nuevo usuario mediante PUT cuando el ID no existe previamente (Upsert)
    * def nonExistingId = 'ID_NEW_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * def newUserPayload = getRandomUser()

    Given path 'usuarios', nonExistingId
    And request newUserPayload
    When method PUT
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"
    And match response._id == '#notnull'

  Scenario: Validar error 400 al intentar actualizar un usuario con un email ya registrado por otro
    * def user1 = getRandomUser()
    Given path 'usuarios'
    And request user1
    When method POST
    Then status 201

    * def user2 = getRandomUser()
    Given path 'usuarios'
    And request user2
    When method POST
    Then status 201
    * def user2Id = response._id

    * def payloadConEmailDuplicado = getRandomUser()
    * set payloadConEmailDuplicado.email = user1.email

    Given path 'usuarios', user2Id
    And request payloadConEmailDuplicado
    When method PUT
    Then status 400
    And match response == { "message": "Este email já está sendo usado" }