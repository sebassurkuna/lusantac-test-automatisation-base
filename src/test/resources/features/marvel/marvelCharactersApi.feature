@marvel_characters_api @iniciativa_marvel
Feature: API de Personajes Marvel (microservicio para gestión de personajes)

    Background:
        * url port_marvel_api
        * path '/characters'
        * def generarHeaders =
            """
            function() {
            return {
            "Content-Type": "application/json"
            };
            }
            """
        * def headers = generarHeaders()
        * headers headers
        * def setupResult = callonce read('marvelCreateCharacter.feature@crearPersonaje')
        * karate.log('ID generado en setup:', setupResult.characterId)
        * def id = setupResult.characterId

    # ============= POST - Pruebas adicionales =============
    @id:1 @crearPersonaje @solicitudExitosa201
    Scenario: T-API-MARVEL-CA01-Crear personaje exitosamente 201 - karate
        * def jsonData = read('classpath:data/marvel/request_create_character.json')
        * def randomId = Math.floor(Math.random() * 100) + 1
        * jsonData.name = jsonData.name +'-'+ randomId
        And request jsonData
        When method POST
        Then status 201
        And match response != null
        And match response.name == jsonData.name

    @id:2 @crearPersonaje @errorValidacion400
    Scenario: T-API-MARVEL-CA02-Crear personaje con datos inválidos 400 - karate
        * def jsonData = read('classpath:data/marvel/request_create_invalid_character.json')
        And request jsonData
        When method POST
        Then status 400

    @id:3 @crearPersonaje @errorValidacion400
    Scenario: T-API-MARVEL-CA03-Crear personaje con nombre duplicado 400 - karate
        * def jsonData = read('classpath:data/marvel/request_create_character.json')
        And request jsonData
        When method POST
        Then status 400

    # ============= GET - Pruebas de obtención de personajes =============
    @id:4 @obtenerPersonajes @solicitudExitosa200
    Scenario: T-API-MARVEL-CA04-Obtener todos los personajes 200 - karate
        When method GET
        Then status 200
        And match response != null

    @id:5 @obtenerPersonajePorId @solicitudExitosa200
    Scenario: T-API-MARVEL-CA05-Obtener personaje por ID 200 - karate
        Given path + id
        When method GET
        Then status 200
        And match response != null

    @id:6 @obtenerPersonajePorId @errorNoEncontrado404
    Scenario: T-API-MARVEL-CA06-Obtener personaje con ID inexistente 404 - karate
        Given path '/999'
        When method GET
        Then status 404

    # ============= PUT - Pruebas de actualización de personajes =============
    @id:7 @actualizarPersonaje @solicitudExitosa200
    Scenario: T-API-MARVEL-CA07-Actualizar personaje exitosamente 200 - karate
        Given path + id
        * def updateData = read('classpath:data/marvel/request_update_character.json')
        And request updateData
        When method PUT
        Then status 200
        And match response != null
        And match response.description == updateData.description

    @id:8 @actualizarPersonaje @errorNoEncontrado404
    Scenario: T-API-MARVEL-CA08-Actualizar personaje con ID inexistente 404 - karate
        Given path '/999'
        * def updateData = read('classpath:data/marvel/request_update_character.json')
        And request updateData
        When method PUT
        Then status 404

    # ============= DELETE - Pruebas de eliminación de personajes =============
    @id:9 @eliminarPersonaje @solicitudExitosa204
    Scenario: T-API-MARVEL-CA09-Eliminar personaje exitosamente 204 - karate
        # Eliminamos el personaje
        Given path + id
        When method DELETE
        Then status 204

    @id:10 @eliminarPersonaje @errorNoEncontrado404
    Scenario: T-API-MARVEL-CA10-Eliminar personaje con ID inexistente 404 - karate
        Given path '/999'
        When method DELETE
        Then status 404
