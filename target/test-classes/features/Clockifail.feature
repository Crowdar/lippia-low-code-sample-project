@ClockiFail
Feature: Caminos con errores

  @GetWorkspace´sE400 #Reemplazo el GET por POST
  Scenario: Trae la lista completa de workspace´s
    Given base url https://api.clockify.me
    And endpoint /api/v1/workspaces
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    When execute method POST
    Then the status code should be 400


  @GetWorkspace´sE401 #Doy una api key equivocada
  Scenario: Trae la lista completa de workspace´s
    Given base url https://api.clockify.me
    And endpoint /api/v1/workspaces
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE44GQtZjM5OTBmY2JkNWZk
    When execute method GET
    Then the status code should be 401


  @GetWorkspace´sE404 #Endpoint equivocado
  Scenario: Trae la lista completa de workspace´s
    Given base url https://api.clockify.me
    And endpoint /api/v1/workspace
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    When execute method GET
    Then the status code should be 404


  @AddProjectE400 #Proyecto ya existe
  Scenario: Añade al workspace un nuevo project
    Given call Clockify.feature@GetWorkspace´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    And body addProjectBody.json
    When execute method POST
    Then the status code should be 400

  @AddProjectE401 #Doy una api key equivocada
  Scenario: Añade al workspace un nuevo project
    Given call Clockify.feature@GetWorkspace´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header Content-Type = application/json
    And header Accept = /
    And header xapikey = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    And body addProjectBody.json
    When execute method POST
    Then the status code should be 401

  @AddProjectE404 #Endpoint equivocado
  Scenario: Añade al workspace un nuevo project
    Given call Clockify.feature@GetWorkspace´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/project
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    And body addProjectBody.json
    When execute method POST
    Then the status code should be 404

  @GetProject´sE400 #Reemplazo GET por POST
  Scenario: Trae todos los proyectos creados en el workspace
    Given call Clockify.feature@GetWorkspace´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    When execute method POST
    Then the status code should be 400


  @GetProject´sE401 #Doy una api key equivocada
  Scenario: Trae todos los proyectos creados en el workspace
    Given call Clockify.feature@GetWorkspace´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE44GQtZjM5OTBmY2JkNWZk
    When execute method GET
    Then the status code should be 401


  @GetProject´sE404 #Endpoint equivocado
  Scenario: Trae todos los proyectos creados en el workspace
    Given call Clockify.feature@GetWorkspace´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/proyecto
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    When execute method GET
    Then the status code should be 404


  @FindProjectE400 #ProjectId incorrecto
  Scenario: Busca un project por su ID
    Given call Clockify.feature@GetProject´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/ProyectoId
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    When execute method GET
    Then the status code should be 400

  @FindProjectE401 #Api key faltante
  Scenario: Busca un project por su ID
    Given call Clockify.feature@GetProject´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 401

  @FindProjectE404 #Endpoint equivocado
  Scenario: Busca un project por su ID
    Given call Clockify.feature@GetProject´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/project/{{projectId}}
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    When execute method GET
    Then the status code should be 404


  @UpdateProjectOnWorkspaceE400 #Endpoint erroneo por project ID
  Scenario: Modifica el nombre del project
    Given call Clockify.feature@GetProject´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    And body updateProject.json
    When execute method PUT
    Then the status code should be 400

  @UpdateProjectOnWorkspaceE401 #Sin Api key
  Scenario: Modifica el nombre del project
    Given call Clockify.feature@GetProject´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And header Content-Type = application/json
    And header Accept = /
    And body updateProject.json
    When execute method PUT
    Then the status code should be 401

  @UpdateProjectOnWorkspaceE404 #Endpoint erroneo por campo
  Scenario: Modifica el nombre del project
    Given call Clockify.feature@GetProject´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/project/{{projectId}}
    And header Content-Type = application/json
    And header Accept = /
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk
    And body updateProject.json
    When execute method PUT
    Then the status code should be 404