class AvatarsIO
	constructor: (@token) ->
	
	create: (selector) -> new AvatarsIO.Uploader(@token, selector) # factory method

class AvatarsIO.Uploader
	listeners: {} # collection of listeners for events
	
	constructor: (@token, @selector) ->
		@socket = new easyXDM.Socket
			remote: "http://avatars.io/v1/upload?authorization=#{ @token }"
			onMessage: (message, origin) =>	@emit 'complete', message
		
		@widget = new AjaxUpload $(@selector)[0],
			action: "http://avatars.io/v1/upload?authorization=#{ @token }"
			name: 'avatar'
			allowedExtensions: ['jpg', 'jpeg', 'png', 'gif']
			onSubmit: => @emit 'new'
		
		@emit 'init'
	
	on: (event, listener) ->
		@listeners[event] = [] if not @listeners[event]
		@listeners[event].push listener
	
	emit: (event, args, context = @) ->
		return if not @listeners[event]
		
		listener.apply(context, [args]) for listener in @listeners[event]
		
		undefined