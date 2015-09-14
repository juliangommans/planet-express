@PlanetExpress.module 'CrewApp.Edit', (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: 'crew/edit/edit_layout'
    regions:
      formRegion: "#form-region"
      titleRegion: "#title-region"

  class Edit.Title extends App.Views.ItemView
    template: 'crew/edit/edit_title'

    modelEvents:
      "updated" : "render"

  class Edit.Crew extends App.Views.ItemView
    template: 'crew/edit/edit_crew'

    # onFormSubmit: (data) ->
    #   console.log "formsubmission", data
    #   false
