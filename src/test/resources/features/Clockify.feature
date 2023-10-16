@Clockify
Feature: Clockify

  Background:
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = NGY2NGQ1N2ItZWY0NC00OWFiLWIzNjktY2ZmMzE3MmU0ZTU0

  @WorkSpace
  Scenario: Listar Espacio de Trabajo
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define workspaceId = $.[0].id

  @Crear
  Scenario: Crear un proyecto
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And set value "ProyectoTest" of key name in body agregarProyecto.json
    When execute method POST
    Then the status code should be 201

  @ListarProyecto
  Scenario: Listar proyecto
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id

  @BuscarporID
  Scenario: Buscar proyecto por ID
    Given call Clockify.feature@ListarProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200

  @RenombrarProyecto
  Scenario: Renombrar un proyecto
    Given call Clockify.feature@ListarProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And set value "ProyectoRenombrado" of key name in body agregarProyecto.json
    When execute method PUT
    Then the status code should be 200
    And response should be name = ProyectoRenombrado

