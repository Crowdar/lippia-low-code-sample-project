Feature: updateProjectEstimate

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = NTZhNWVmN2UtNjI1OS00OGU2LTg1ZDEtYmZkOWM1NzZjNDFk
    And base url env.base_url_clockify
    * define nombreProyectoMembership = Crowdar2023Membership

  @ListWorkspaceMembership
  Scenario:
    Given base url env.base_url_clockify
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id


  @CreateProjectMembership
  Scenario: Create project
    Given call updateProjectMembership.feature@ListWorkspaceMembership
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyectoMembership}}" of key name in body addProject.json
    When execute method POST
    Then the status code should be 201
    * define idProject = $.id

  @UpdateMembership
  Scenario: Update Membership project
    Given call updateProjectMembership.feature@CreateProjectMembership
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}/memberships
    And set value "110" of key amount in body membership.json
    When execute method PATCH
    Then the status code should be 200


  @UpdateMembership400
  Scenario: Membership Project 400 Bad Request
    Given call updateProjectMembership.feature@ListWorkspaceMembership
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/$$/memberships
    And set value "110" of key amount in body membership.json
    When execute method PATCH
    Then the status code should be 400


  @UpdateMembership401
  Scenario: Membership Project 401 Unauthorized
    Given call updateProjectMembership.feature@ListWorkspaceMembership
    And header x-api-key = 32423423423fgdfgaefad
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/6535738fc64c131fb4e8f984/memberships
    And set value "200" of key amount in body membership.json
    When execute method PATCH
    Then the status code should be 401

  @UpdateMembership404
  Scenario: Membership Project 404 Not Found
    Given call updateProjectMembership.feature@ListWorkspaceMembership
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/$$$/4444
    And set value "200" of key amount in body membership.json
    When execute method PATCH
    Then the status code should be 404