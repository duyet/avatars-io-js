class AvatarsIO
	constructor: (@token) ->
	
	create: (input) -> new AvatarsIO.Uploader(@token, input) # factory method

class AvatarsIO.Uploader
	listeners: {} # collection of listeners for events
	identifier: ''
	allowedExtensions: ['jpg', 'jpeg', 'png', 'gif']
	
	constructor: (@token, @input) ->
		@initialize()
		@emit 'init'
	
	initialize: ->
		url = "http://avatars.io/v1/upload?authorization=#{ @token }#{ if @identifier.length > 0 then '&shortcut=' + @identifier else '' }"
		@socket = new easyXDM.Socket
			remote: url
			onMessage: (message, origin) =>	@emit 'complete', message
		
		if not @widget
			@widget = new AjaxUpload @input,
				action: url
				name: 'avatar'
				allowedExtensions: @allowedExtensions
				onSubmit: => @emit 'new'
	
	setAlbum: (@identifier = '') ->
		setTimeout =>
			@socket.destroy() if @socket
			@initialize()
		, 100
	
	setAlbumID: -> @setAlbum.apply @, arguments
	
	setAllowedExtensions: (@allowedExtensions = []) ->
		@widget._settings.allowedExtensions = @allowedExtensions if @widget
	
	on: (event, listener) ->
		@listeners[event] = [] if not @listeners[event]
		@listeners[event].push listener
	
	emit: (event, args, context = @) ->
		return if not @listeners[event]
		
		listener.apply(context, [args]) for listener in @listeners[event]
		
		undefined