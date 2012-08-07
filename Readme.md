# Avatars.io uploader for browsers

Use this library to upload images to avatars.io and get URLs to them. No server-side configuration required.

# Getting Started

First, go to [avatars.io](http://avatars.io) and obtain your authorization token for use on client side.

Include *avatars.io.min.js* in your web page(2.6kb) and configure it:

```html
<script src="avatars.io.min.js"></script>
<script>
var client = new AvatarsIO('Your public token'); // obtain at http://avatars.io/

$(function(){
	var uploader = client.create('#avatar'); // selector for input[type="file"] field, here #avatar, for example
	uploader.setAllowedExtensions(['png', 'jpg']); // optional, defaults to png, gif, jpg, jpeg
	uploader.on('complete', function(url){
		alert(url); // for example, http://avatars.io/ua3aS5a
	});
});
</script>
```

Next, set up *file* field with *#avatar* id (for example):

```html
<div> <!-- surround it with some container element -->
	<input type="file" id="avatar">
</div>
```

# Events

Library emits such events as: init, new, complete. You can add listeners to these using **on** method:

```javascript
uploader.on('init', function(){
	// instance of uploader just finished initializing
});

uploader.on('new', function(){
	// fires when new avatar starts uploading
});

uploader.on('complete', function(url){
	// fires when avatar finished uploading
});
```

# License

&copy; Chute Corporation.