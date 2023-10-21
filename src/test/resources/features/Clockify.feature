@Clockify
Feature: Clockify

  Background:
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = NGY2NGQ1N2ItZWY0NC00OWFiLWIzNjktY2ZmMzE3MmU0ZTU0

  @WS @WorkSpace @Exitoso @200
  Scenario: Traer Workspaces
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define workspaceId = $.[0].id

  @WS @WorkSpaceErrorHeader @WorkSpaceFallido @401
  Scenario: Traer workspaces con accion no autorizada
    Given header x-api-key = /no_header/
    And base url env.base_url_clockify
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 401

  @WS @WorkSpaceErrorEndpoint @WorkSpaceFallido @404
  Scenario: Traer workspaces con accion no encontrada
    Given base url env.base_url_clockify
    And endpoint /no_endpoint/
    When execute method GET
    Then the status code should be 404

  @CP @CrearProyecto @Exitoso @201
  Scenario: Crear un proyecto
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And set value "Proyecto1" of key name in body agregarProyecto.json
    When execute method POST
    Then the status code should be 201

  @CP @CrearProyectoErrorBody @CrearProyectoFallido @Error @400
  Scenario: Crear un proyecto sin respuesta
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And set value "ProyectoTest" of key name in body no json
    When execute method POST
    Then the status code should be 400

  @CP @CrearProyectoErrorHeader @CrearProyectoFallido @Error @401
  Scenario: Crear un proyecto con accion no autorizado
    Given header x-api-key = /no_header/
    And call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And set value "ProyectoTest" of key name in body agregarProyecto.json
    When execute method POST
    Then the status code should be 401

  @CP @CrearProyectoErrorEndpoint @CrearProyectoFallido @Error @404
  Scenario: Crear un proyecto con accion no encontrada
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /no_endpoint/
    And set value "ProyectoTest" of key name in body agregarProyecto.json
    When execute method POST
    Then the status code should be 404

  @TP @TraerProyecto @Exitoso @200
  Scenario: Traer proyecto
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id

  @TP @TraerProyectooErrorHeader @TraerProyectoFallido @Error @401
  Scenario: Traer proyecto con accion no autorizado
    Given header x-api-key = /no_header/
    And call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/
    When execute method GET
    Then the status code should be 401

  @TP @TraerProyectoErrorEndpoint @TraerProyectoFallido @Error @404
  Scenario: Traer proyecto con accion no encontrada
    Given call Clockify.feature@WorkSpace
    And base url env.base_url_clockify
    And endpoint /no_endpoint/
    When execute method GET
    Then the status code should be 404

  @BID @BuscarporID @Exitoso @200
  Scenario: Buscar proyecto por ID
    Given call Clockify.feature@TraerProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200

  @BID @BuscarporIDErrorHeader @BuscarporIDFallido @Error @401
  Scenario: Buscar proyecto por ID con accion no autorizado
    Given header x-api-key = /no_header/
    And call Clockify.feature@TraerProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 401

  @BID @BuscarporIDErrorEndpoint @BuscarporIDFallido @Error @404
  Scenario: Buscar proyecto por ID con accion no encontrada
    Given call Clockify.feature@TraerProyecto
    And base url env.base_url_clockify
    And endpoint /no_endpoint/
    When execute method GET
    Then the status code should be 404

  @RP @RenombrarProyecto @Exitoso @200
  Scenario: Renombrar un proyecto
    Given call Clockify.feature@TraerProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And set value "ProyectoRenombrado" of key name in body agregarProyecto.json
    When execute method PUT
    Then the status code should be 200
    And response should be name = ProyectoRenombrado

  @RP @RenombrarProyectoErrorHeader @RenombrarProyectoFallido @Error @401
  Scenario: Renombrar un proyecto con accion no autorizado
    Given header x-api-key = /no_header/
    And call Clockify.feature@TraerProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And set value "ProyectoRenombrado" of key name in body agregarProyecto.json
    When execute method PUT
    Then the status code should be 401

  @RP @RenombrarProyectoErrorBody @RenombrarProyectoFallido @Error @400
  Scenario: Renombrar un proyecto
    Given call Clockify.feature@TraerProyecto
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And set value "ProyectoRenombrado" of key name in body no json
    When execute method PUT
    Then the status code should be 400

  @RP @RenombrarProyectoErrorEndpoint @RenombrarProyectoFallido @Error @404
  Scenario: Renombrar un proyecto
    Given call Clockify.feature@TraerProyecto
    And base url env.base_url_clockify
    And endpoint /no_header/
    And set value "ProyectoRenombrado" of key name in body agregarProyecto.json
    When execute method PUT
    Then the status code should be 404



