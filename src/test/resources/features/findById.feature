Feature: Find by id

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = NTZhNWVmN2UtNjI1OS00OGU2LTg1ZDEtYmZkOWM1NzZjNDFk
    And base url env.base_url_clockify

  @ListWorkspaceFindId
  Scenario: Get all workspaces
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id

  @ListProjectsFindById
  Scenario: get all projects
    Given call findById.feature@ListWorkspaceFindId
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * define idProject = $[0].id

  @FindId
  Scenario: get project by id
    Given call findById.feature@ListProjectsFindById
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    When execute method GET
    Then the status code should be 200

  @FindId400
  Scenario: get project Bad Request
    Given call findById.feature@ListWorkspaceFindId
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/013ty9p1
    When execute method GET
    Then the status code should be 400

  @FindId401
  Scenario: get project Unauthorised
    Given header x-api-key = ÑTZhNWVmN2UtNjI1OS00OGU2LTg1ZDEtYmZkOWM1NzZjNDFk
    And call findById.feature@ListProjectsFindById
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    When execute method GET
    Then the status code should be 401

  @FindId404
  Scenario: get project by id Not Found
    Given call findById.feature@ListWorkspaceFindId
    And endpoint /v1/workspaces/{{idWorkspace}}/projectsgfkghl/6535738fc64c131fb4e8f984
    When execute method GET
    Then the status code should be 404