@PlanetExpress.module 'CrewApp.New', (New, App, Backbone, Marionette, $, _) ->

  class New.Crew extends App.Views.ItemView
    template: 'crew/new/_new'

    form:
      buttons:
        placement: "left"
