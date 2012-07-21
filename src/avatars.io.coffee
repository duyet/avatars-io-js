class AvatarsIO
	constructor: (@token) ->
	
	create: (selector) -> new AvatarsIO.Uploader(@token, selector)

class AvatarsIO.Uploader
	listeners: {}
	state: 'new'
	currentShortcut: ''
	
	constructor: (@token, @selector) ->
		@widget = new AjaxUpload $(@selector)[0],
			action: "http://avatars.io/v1/upload?shortcut=#{ @currentShortcut }&authorization=#{ @token }"
			name: 'avatar'
			allowedExtensions: ['jpg', 'jpeg', 'png', 'gif']
			onSubmit: =>
				@currentShortcut = @shortcut()
				@widget._settings.action = "http://avatars.io/v1/upload?shortcut=#{ @currentShortcut }&authorization=#{ @token }"
				@emit 'new'
			
			onComplete: =>
				@emit 'complete', "http://avatars.io/#{ @currentShortcut }"
		
		@emit 'init'
	
	on: (event, listener) ->
		@listeners[event] = [] if not @listeners[event]
		@listeners[event].push listener
	
	emit: (event, args, context = @) ->
		return if not @listeners[event]
		
		listener.apply(context, [args]) for listener in @listeners[event]
		
		undefined
	
	shortcut: ->
		value = 'u'
		possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'

		loop
			break if value.length is 10
			value += possible.charAt(Math.floor(Math.random() * possible.length))

		value