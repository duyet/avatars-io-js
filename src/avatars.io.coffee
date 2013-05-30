class AvatarsIO
	constructor: (@token) ->
	
	create: (input) -> new AvatarsIO.Uploader(@token, input) # factory method

class AvatarsIO.Uploader
	identifier: ''
	host: 'http://avatars.io'
	allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'JPG', 'JPEG', 'PNG', 'GIF']
	
	constructor: (@token, @input) ->
		@initialize()
		@emit 'init'
	
	initialize: ->
		url = "#{ @host }/v1/upload?authorization=#{ @token }#{ if @identifier.length > 0 then '&shortcut=' + @identifier else '' }"
		@socket = new easyXDM.Socket
			remote: url
			onMessage: (message, origin) =>
				if not message
					return @emit 'error'
				
				@emit 'complete', [message]
		
		if not @widget
			@widget = new AjaxUpload @input,
				action: url
				name: 'avatar'
				allowedExtensions: @allowedExtensions
				onSubmit: => @emit 'start'
	
	setHost: (@host = 'http://avatars.io') ->
	
	setIdentifier: (@identifier = '') ->
		setTimeout =>
			@socket.destroy() if @socket
			@initialize()
		, 100
	
	setAlbum: -> @setIdentifier.apply @, arguments # deprecated
	setAlbumID: -> @setAlbum.apply @, arguments # deprecated
	
	setAllowedExtensions: (@allowedExtensions = []) ->
		for extension in @allowedExtensions
			@allowedExtensions.push extension.toUpperCase()
		
		@widget._settings.allowedExtensions = @allowedExtensions if @widget
	
	listeners: {},
	
	on: (event, listener) ->
		@listeners[event] = [] if not @listeners[event]
		@listeners[event].push listener
	
	emit: (event, args, context = @) ->
		return if not @listeners[event]
		
		listener.apply(context, args) for listener in @listeners[event]
		
		undefined