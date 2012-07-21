# Avatars.io uploader for browsers

Use this library to upload images to avatars.io and get URLs to them. No server-side configuration required.

# Getting Started

First, go to [avatars.io](http://avatars.io) and obtain your authorization token for use on client side.

Include *aio.min.* in your web page(2.6kb) and configure it:

```html
<script src="avatars.io.min.js"></script>
<script>
AIOUploader.token = 'Your authorization token you obtained for avatars.io';

$(function(){
	new AIOUploader('#avatar', function(err, url){
		alert(url);
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

**Note**: This component requires jQuery.

# License

MIT.