Feature: Delete

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = NTZhNWVmN2UtNjI1OS00OGU2LTg1ZDEtYmZkOWM1NzZjNDFk
    And base url env.base_url_clockify
    * define nombreProyecto = Crowdar2023

  @ListWorkspaceDelete
  Scenario:
    Given base url env.base_url_clockify
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id


  @CreateProjectDelete
  Scenario: Crear un proyecto
    Given call delete.feature@ListWorkspaceDelete
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyecto}}" of key name in body addProject.json
    When execute method POST
    Then the status code should be 201
    * define idProject = $.id

  @UpdateProjectDelete
  Scenario: Update Project
    Given call delete.feature@CreateProject
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And set value "true" of key archived in body updateProjectToArchive.json
    When execute method PUT
    Then the status code should be 200

  @DeleteProject
  Scenario: Delete Project
    Given call delete.feature@UpdateProject
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    When execute method DELETE
    Then the status code should be 200

  @DeleteProject400
  Scenario: Delete Project Bad Request
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/cuaqluiera
    When execute method DELETE
    Then the status code should be 400

  @DeleteProject401
  Scenario: Delete Project Unauthorized
    Given header x-api-key = 32423423423fgdfgaefad
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/653568cff202ee63efd5493b
    When execute method DELETE
    Then the status code should be 401

  @DeleteProject404
  Scenario: Delete Project Not Found
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/project51s/653568cff202ee63efd5493b
    When execute method DELETE
    Then the status code should be 404

