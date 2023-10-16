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

  @WorkSpaceNoAutorizado
  Scenario: Listar Espacio de Trabajo
    Given header x-api-key = n
    And base url env.base_url_clockify
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 401

  @WorkSpaceNoEncontrado
  Scenario: Listar Espacio de Trabajo
    Given base url env.base_url_clockify
    And endpoint /v1/workspace
    When execute method GET
    Then the status code should be 404

  @CrearProyecto
  Scenario: Crear un proyecto
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And set value "ProyectoTest" of key name in body agregarProyecto.json
    When execute method POST
    Then the status code should be 201

  @CrearProyectoMalaRespuesta
  Scenario: Crear un proyecto
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And set value "ProyectoTest" of key name in body agregarProyecto.jso
    When execute method POST
    Then the status code should be 400

  @CrearProyectoNoAutorizado
  Scenario: Crear un proyecto
    Given header x-api-key = N
    And call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And set value "ProyectoTest" of key name in body agregarProyecto.json
    When execute method POST
    Then the status code should be 401

  @CrearNoEncontrado
  Scenario: Crear un proyecto
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/project
    And set value "ProyectoTest" of key name in body agregarProyecto.json
    When execute method POST
    Then the status code should be 404

  @ListarProyecto
  Scenario: Listar proyecto
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id

  @ListarProyectooNoAutorizado
  Scenario: Listar proyecto
    Given header x-api-key = N
    And call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/
    When execute method GET
    Then the status code should be 401

  @ListarProyectoNoEncontrado
  Scenario: Listar proyecto
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/proje/
    When execute method GET
    Then the status code should be 404

  @BuscarporID
  Scenario: Buscar proyecto por ID
    Given call Clockify.feature@ListarProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200

  @BuscarporIDNoAutorizado
  Scenario: Buscar proyecto por ID
    Given header x-api-key = N
    And call Clockify.feature@ListarProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 401

  @BuscarporIDNoEncontrado
  Scenario: Buscar proyecto por ID
    Given call Clockify.feature@ListarProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projec/{{projectId}}
    When execute method GET
    Then the status code should be 404

  @RenombrarProyecto
  Scenario: Renombrar un proyecto
    Given call Clockify.feature@ListarProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And set value "ProyectoRenombrado" of key name in body agregarProyecto.json
    When execute method PUT
    Then the status code should be 200
    And response should be name = ProyectoRenombrado

  @RenombrarProyectoFallo1
  Scenario: Renombrar un proyecto
    Given header x-api-key = N
    And call Clockify.feature@ListarProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And set value "ProyectoRenombrado" of key name in body agregarProyecto.json
    When execute method PUT
    Then the status code should be 401

  @RenombrarProyectoFallo2
  Scenario: Renombrar un proyecto
    Given call Clockify.feature@ListarProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And set value "ProyectoRenombrado" of key name in body no json
    When execute method PUT
    Then the status code should be 400

  @RenombrarProyectoFallo3
  Scenario: Renombrar un proyecto
    Given call Clockify.feature@ListarProyecto
    And base url env.base_url_clockify
    And endpoint /v
    And set value "ProyectoRenombrado" of key name in body agregarProyecto.json
    When execute method PUT
    Then the status code should be 404



