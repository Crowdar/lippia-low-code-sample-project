Feature: Update Projects

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = NTZhNWVmN2UtNjI1OS00OGU2LTg1ZDEtYmZkOWM1NzZjNDFk
    And base url env.base_url_clockify
    * define nombreProyectoUpdate = Crowdar2023Update

  @ListWorkspaceUpdateProjects
  Scenario: Get all workspaces
    Given base url env.base_url_clockify
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id


  @CreateProjectForUpdate
  Scenario: Create project for update
    Given call updateProjects.feature@ListWorkspaceUpdateProjects
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyectoUpdate}}" of key name in body addProjectUpdate.json
    When execute method POST
    Then the status code should be 201
    * define idProject = $.id

  @UpdateProject
  Scenario: Update Project
    Given call updateProjects.feature@CreateProjectUpdate
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And set value "true" of key archived in body updateProjectToArchive.json
    When execute method PUT
    Then the status code should be 200

  @UpdateProject400
  Scenario: Update Project Bad Request
    Given call updateProjects.feature@ListWorkspaceUpdateProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/hhhjjj
    And set value "true" of key archived in body updateProjectToArchive.json
    When execute method PUT
    Then the status code should be 400

  @UpdateProject401
  Scenario: Update Project Unauthorised
    Given header x-api-key = 32423423423fgdfgaefad
    And call updateProjects.feature@ListWorkspaceUpdateProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/6535738fc64c131fb4e8f984
    And set value "true" of key archived in body updateProjectToArchive.json
    When execute method PUT
    Then the status code should be 401

  @UpdateProject404
  Scenario: Update Project Not Found
    Given call updateProjects.feature@ListWorkspaceUpdateProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects1234/6535738fc64c131fb4e8f984
    And set value "true" of key archived in body updateProjectToArchive.json
    When execute method PUT
    Then the status code should be 404