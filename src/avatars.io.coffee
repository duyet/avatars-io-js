class AvatarsIO
	constructor: (@token) ->
	
	create: (selector) -> new AvatarsIO.Uploader(@token, selector) # factory method

class AvatarsIO.Uploader
	listeners: {} # collection of listeners for events
	shortcut: ''
	allowedExtensions: ['jpg', 'jpeg', 'png', 'gif']
	
	constructor: (@token, @selector) ->
		@initialize()
		@emit 'init'
	
	initialize: ->
		url = "http://avatars.io/v1/upload?authorization=#{ @token }#{ if @shortcut.length > 0 then '&shortcut=' + @shortcut else '' }"
		@socket = new easyXDM.Socket
			remote: url
			onMessage: (message, origin) =>	@emit 'complete', message
		
		if not @widget
			@widget = new AjaxUpload $(@selector)[0],
				action: url
				name: 'avatar'
				allowedExtensions: @allowedExtensions
				onSubmit: => @emit 'new'
	
	setShortcut: (@shortcut = '') ->
		setTimeout =>
			@socket.destroy() if @socket
			@initialize()
		, 100
	
	setAllowedExtensions: (@allowedExtensions = []) ->
		@widget._settings.allowedExtensions = @allowedExtensions if @widget
	
	on: (event, listener) ->
		@listeners[event] = [] if not @listeners[event]
		@listeners[event].push listener
	
	emit: (event, args, context = @) ->
		return if not @listeners[event]
		
		listener.apply(context, [args]) for listener in @listeners[event]
		
		undefined