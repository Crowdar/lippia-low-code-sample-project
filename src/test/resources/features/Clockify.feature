@Clockify
Feature: Camino feliz

  Background:
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk

  @GetWorkspace´s
  Scenario: Trae la lista completa de workspace´s
    Given base url http://api.clockify.me/api
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define workspaceId = $.[0].id

  @AddProject
  Scenario: Añade al workspace un nuevo project
    Given call Clockify.feature@GetWorkspace´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And body addProjectBody.json
    When execute method POST
    Then the status code should be 201

  @GetProject´s
  Scenario: Trae todos los proyectos creados en el workspace
    Given call Clockify.feature@GetWorkspace´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id

  @FindProjectByID
  Scenario: Busca un project por su ID
    Given call Clockify.feature@GetProject´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then the status code should be 200

  @UpdateProjectOnWorkspace
  Scenario: Modifica el nombre del project
    Given call Clockify.feature@GetProject´s
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    And body updateProject.json
    When execute method PUT
    Then the status code should be 200
    And response should be name = Silve