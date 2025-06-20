@marvel_characters_api @iniciativa_marvel @setup
Feature: Crear Personaje Marvel

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

  @id:1 @crearPersonaje @solicitudExitosa201
  Scenario: T-API-MARVEL-CA01-Crear personaje exitosamente 201 - karate
    * def jsonData = read('classpath:data/marvel/request_create_character.json')
    And request jsonData
    When method POST
    Then status 201
    And match response != null
    And match response.name == jsonData.name
    * def characterId = response.id
    * karate.log('ID del personaje creado:', characterId)
