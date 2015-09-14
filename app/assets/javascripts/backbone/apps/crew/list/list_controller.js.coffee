@PlanetExpress.module 'CrewApp.List', (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      window.c = @
      crew = App.request("crew:entities")

      App.execute "when:fetched", crew, =>

        @layout = @getLayoutView()

        # @listenTo @layout, "close", @close

        @listenTo @layout, "show", =>
          @titleRegion()
          @panelRegion()
          @crewRegion crew

        @show @layout

    onClose: ->
      console.log "view has been destroyed (list controller)"

    getLayoutView: ->
      new List.Layout

    titleRegion: ->
      titleView = @getTitleView()
      @layout.titleRegion.show titleView

    panelRegion: ->
      panelView = @getPanelView()

      @listenTo panelView, "show:new:crew:panel", =>
        @newRegion()

      @layout.panelRegion.show panelView

    newRegion: ->
      region = @layout.newRegion
      newView = App.request "new:crew:member:view"

      @listenTo newView, "form:cancel", =>
        region.reset()

      region.show newView

    crewRegion: (crew) ->

      crewView = @getCrewView crew

      @listenTo crewView, "childview:crew:member:clicked", (child, args) ->
        App.vent.trigger "crew:member:clicked", args.model

      @listenTo crewView, "childview:crew:delete:clicked", (child, args) ->
        model = args.model
        if confirm "You sure you want to kill #{model.get('name')}?"
          model.destroy()
        else
          false

      @layout.crewRegion.show crewView

    getTitleView: ->
      new List.Title

    getPanelView: ->
      new List.Panel

    getNewView: ->
      new List.New

    getCrewView: (crew) ->
      new List.Crew
        collection: crew
