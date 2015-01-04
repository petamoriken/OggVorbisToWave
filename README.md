OggVorbis To Wave
==================

Add `window.oggVorbisToWave`.

Enable to play OggVorbis in Frontend-JavaScript by Web Audio API's `decodeAudioData` in Safari and IE10~ (use [WAAPISim]).

	var ctx = null;
	if(typeof webkitAudioContext !== "undefined") {
		ctx = new webkitAudioContext();
	} else if(typeof AudioContext !== "undefined") {
		ctx = new AudioContext();
	} else {
		console.log("Can't use Web Audio API");
	}

	if(ctx !== null) {
		var req = new XMLHttpRequest();
		req.open("GET", "test.ogg", true);
		req.responseType = "arraybuffer";
		req.onload = function(){
		
			var oggArrayBuffer = req.response;
			ctx.decodeAudioData(oggArrayBuffer, doSomething, function() {

				// ctx.decodeAudioData doesn't support OggVorbis
				var waveArrayBuffer = oggVorbisToWave(oggArrayBuffer);
				ctx.decodeAudioData(waveArrayBuffer, doSomething);
				
			});
			
		};
		req.send(null);

		function doSomething(AudioBuffer) {
			// do something
		}
	}


##License

Under MIT License

this software includes the work that is distributed in the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0)  
[libvorbis.js] - port of libvorbis to JavaScript using emscripten  
by Bjorn Melinder bjorn@soundtrap.com

[WAAPISim]:https://github.com/g200kg/WAAPISim
[libvorbis.js]:https://github.com/bjornm/libvorbis-js