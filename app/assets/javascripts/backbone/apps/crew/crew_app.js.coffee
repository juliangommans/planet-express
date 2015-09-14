@PlanetExpress.module "CrewApp", (CrewApp, App, Backbone, Marionette, $, _) ->

  class CrewApp.Router extends Marionette.AppRouter
    appRoutes:
      "crew/:id/edit" : "editCrew"
      "crew" : "list"

  API =
    list: ->
      new CrewApp.List.Controller
    newCrew: ->
      CrewApp.New.Controller.new()
    editCrew: (id, member) ->
      CrewApp.Edit.Controller.edit id, member

  App.reqres.setHandler "new:crew:member:view", ->
    API.newCrew()

  App.vent.on "crew:member:clicked crew:created", (member) ->
    App.navigate Routes.edit_crew_path(member.id)
    API.editCrew member.id, member

  App.vent.on "crew:cancelled crew:updated", (member) ->
    App.navigate Routes.crew_index_path()
    API.list()

  App.addInitializer ->
    new CrewApp.Router
      controller: API
