@Workspaces
Feature: getProjects

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = NTZhNWVmN2UtNjI1OS00OGU2LTg1ZDEtYmZkOWM1NzZjNDFk

  @getWorkspacesGetProjetc
  Scenario: Get all workspaces
    Given base url env.base_url_clockify
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id

  @ListProjectsGetProjetc
  Scenario: get all projects
    Given call getProject.feature@getWorkspacesGetProjetc
    And base url env.base_url_clockify
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200

  @ListProjectsGetProjetc400
  Scenario: get all projects Bad request
    Given call getProject.feature@getWorkspacesGetProjetc
    And base url env.base_url_clockify
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/xdd
    When execute method GET
    Then the status code should be 400

  @ListProjectsGetProjetc401
  Scenario: get all projects Unauthorised
    Given call getProject.feature@getWorkspacesGetProjetc
    And header x-api-key = 32423423423fgdfgaefad
    And base url env.base_url_clockify
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 401

  @ListProjectsGetProjetc404
  Scenario: get all projects Not found
    Given call getProject.feature@getWorkspacesGetProjetc
    And base url env.base_url_clockify
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects514
    When execute method GET
    Then the status code should be 404