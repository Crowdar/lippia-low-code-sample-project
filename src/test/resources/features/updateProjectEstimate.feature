Feature: updateProjectEstimate

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = NTZhNWVmN2UtNjI1OS00OGU2LTg1ZDEtYmZkOWM1NzZjNDFk
    And base url env.base_url_clockify
    * define nombreProyecto = Crowdar2023Estimate

  @ListWorkspaceEstimate
  Scenario:
    Given base url env.base_url_clockify
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id


  @CreateProjectEstimate
  Scenario: Crear un proyecto
    Given call updateProjectEstimate.feature@ListWorkspaceEstimate
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyecto}}" of key name in body addProjectUpdate.json
    When execute method POST
    Then the status code should be 201
    * define idProject = $.id

  @UpdateEstimate
  Scenario: Update estimate project
    Given call updateProjectEstimate.feature@CreateProjectEstimate
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/estimate
    And set value "MANUAL" of key type in body updateEstimate.json
    When execute method PATCH
    Then the status code should be 200

  @UpdateEstimate400
  Scenario: Estimate Project Bad Request
    Given call updateProjectEstimate.feature@ListWorkspaceEstimate
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/$$$$/estimate
    And set value "MANUAL" of key type in body updateEstimate.json
    When execute method PATCH
    Then the status code should be 400

  @UpdateEstimate401
  Scenario: Estimate Project Unauthorized
    Given header x-api-key = 32423423423fgdfgaefad
    And call updateProjectEstimate.feature@ListWorkspaceEstimate
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/mandinga
    When execute method PATCH
    Then the status code should be 401

  @UpdateEstimate404
  Scenario: Estimate Project Not Found
    Given call updateProjectEstimate.feature@ListWorkspaceEstimate
    And endpoint /v1/workspaces/{{idWorkspace}}/project51s/mandinga
    When execute method PATCH
    Then the status code should be 404