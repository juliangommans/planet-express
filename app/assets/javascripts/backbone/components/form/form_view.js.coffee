@PlanetExpress.module 'Components.Form', (Form, App, Backbone, Marionette, $, _) ->

  class Form.FormWrapper extends App.Views.Layout
    template: 'form/form'
    tagName: "form"
    attributes: ->
      "data-type": @getFormDataType()
    regions:
      formContentRegion: "#form-content-region"
    ui:
      buttonContainer: "ul.inline-list"
    triggers:
      "submit"                            : "form:submit"
      "click [data-form-button='cancel']" : "form:cancel"

    modelEvents:
      "change:_errors" : "changeErrors"
      "sync:start" : "syncStart"
      "sync:stop" : "syncStop"

    initialize: ->
      @setInstancePropertiesFor "config", "buttons"

    serializeData: ->
      footer: @config.footer
      buttons: @buttons?.toJSON() ? false

    onShow: ->
      _.defer =>
        @focusFirstInput() if @config.focusFirstInput
        @buttonPlacement() if @buttons

    buttonPlacement: ->
      @ui.buttonContainer.addClass @buttons.placement

    focusFirstInput: ->
      @$(":input:visible:enabled:first").focus()

    getFormDataType: ->
      if @model.isNew() then "new" else "edit"

    changeErrors: (model, errors, options) ->
      console.log errors
      if @config.errors
        if _.isEmpty(errors)
          @removeErrors()
        else
          @addErrors errors

    removeErrors: ->
      console.log "the errors have been removed"
      @$(".error").removeClass("error").find("small").remove()

    addErrors: (errors = {}) ->
      for name, array of errors
        @addError name, array[0]

    addError: (name, error) ->
      el = @$("[name='#{name}']")
      small = $("<small>").text(error)
      el.after(small).closest('.row').addClass("error")

    syncStart: (model) ->
      @$el.addClass("opacity") if @config.syncing

    syncStop: (model) ->
      @$el.removeClass("opacity") if @config.syncing
