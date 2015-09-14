@PlanetExpress.module "Views", (Views, App, Backbone, Marionette, $, _) ->

	_remove = Marionette.View::remove

	_.extend Marionette.View::,

    setInstancePropertiesFor: (args...) ->
      for key, val of _.pick(@options, args...)
        @[key] = val

    remove: (args...) ->
      console.log "removing", @
      if @model?.isDestroyed()
        @$el.animate
          backgroundColor: "red"
          width: "75px"
          opacity: 0.1
          top: "-=900"
          left: "-=200"
        ,
          1500
        ,
          =>
            _remove.apply @, args
      else
        _remove.apply @, args

		templateHelpers: ->

			linkTo: (name, url, options = {}) ->
				_.defaults options,
					external: false

				url = "#" + url unless options.external

				"<a href='#{url}'>#{@escape(name)}</a>"
