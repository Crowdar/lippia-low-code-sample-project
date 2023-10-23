@addProject
Feature: addProject

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = NTZhNWVmN2UtNjI1OS00OGU2LTg1ZDEtYmZkOWM1NzZjNDFk
    * define nombreProyecto12 = crow2

  @ListWorkspace123
  Scenario:
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id

  @CreateProjectAddProject
  Scenario: Create project
    Given call addProject.feature@ListWorkspace123
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyecto12}}" of key name in body addProject.json
    When execute method POST
    Then the status code should be 201


  @CreateProject400
  Scenario: Create project Bad Request
    Given call addProject.feature@ListWorkspace123
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyecto12}}" of key name in body addProject214.json
    When execute method POST
    Then the status code should be 400

  @CreateProject401
  Scenario: Create project Unauthorized
    Given call addProject.feature@ListWorkspace123
    Given header x-api-key = gfgfssfssfsfhhjjjj
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyecto12}}" of key name in body addProject.json
    When execute method POST
    Then the status code should be 401

  @CreateProject404
  Scenario: Create project Not Found
    Given call addProject.feature@ListWorkspace123
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/4356465
    And set value "{{nombreProyecto12}}" of key name in body addProject.json
    When execute method POST
    Then the status code should be 404

