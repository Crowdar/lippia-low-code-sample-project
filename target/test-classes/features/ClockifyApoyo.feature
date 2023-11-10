@ClockifyGeneral
Feature: Escenarios de apoyo

  Background:
    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = YTMwNTRmZmMtM2Y3MC00OGVjLWE4OGQtZjM5OTBmY2JkNWZk


  @GetWorkspace
  Scenario: Trae la lista completa de workspace´s
    Given base url http://api.clockify.me/api
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define id = $.[0].id