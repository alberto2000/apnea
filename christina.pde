import processing.serial.*;
import cc.arduino.*;
import processing.video.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
Delay audioDelay;
AudioSnippet audioSnippet;
Movie movie;
Arduino arduino;
Smoother videoSmoother;
Smoother audioSmoother;

// VIDEO BLUR, POSTERIZE, ZOOM, SHAKE
// ONE SHOT SOUNDS
// DISTORT LOOPING SOUND

// "posterize", "pixel", "zoom", "shake"
String videoFilter = "pixel";

// pixel filter settings
int cols, rows;

// other settings
int maxValue = 600;
int minValue = 0;
boolean isFullscreen = false;

void setup() {

	size(1280, 720);
	background(0);

	println(Arduino.list());

	arduino = new Arduino(this, Arduino.list()[7], 57600);
	arduino.pinMode(0, Arduino.INPUT);

	minim = new Minim(this);
	audioSnippet = minim.loadSnippet("movie_sound.mp3");
	audioSnippet.play();
	audioSnippet.loop();

	videoSmoother = new Smoother(20);
	audioSmoother = new Smoother(20);

	movie = new Movie(this, "movie.mp4");
	movie.loop();

}

void draw() {
	image(movie, 0, 0, 1280, 720);
	applyFilter();
	applySoundEffect();
}

void movieEvent(Movie m) {
	m.read();
}

void applyFilter() {

	float value = 0;

	if (videoFilter == "posterize") {
		value = map(arduino.analogRead(0), minValue, maxValue, 2, 255);
	} else if (videoFilter == "pixel") {
		value = map(arduino.analogRead(0), minValue, maxValue, 32, 1);
	}

	videoSmoother.add(value);
	value = round(videoSmoother.read());

	if (videoFilter == "posterize") {
		if (value < 2) value = 2;
		if (value > 255) value = 255;
	} else if (videoFilter == "pixel") {
		if (value < 1) value = 1;
		if (value > 32) value = 32;
	}

	// println("value: " + value);

	if (videoFilter == "posterize") {
		filter(POSTERIZE, value);
	} else if (videoFilter == "pixel") {
		doPixelImage(int(value));
	}

}

void applySoundEffect() {

	float value = map(arduino.analogRead(0), minValue, maxValue, 6, -30);

	audioSmoother.add(value);
	value = round(audioSmoother.read());

	audioSnippet.setGain(value);

}

void doPixelImage(int newPixelSize) {

	if (newPixelSize <= 3) {
		return;
	}

	cols = width / newPixelSize;
	rows = height / newPixelSize;

	movie.loadPixels();

	for (int i = 0; i < cols; i++) {

		for (int j = 0; j < rows; j++) {

			int x = i * newPixelSize;
			int y = j * newPixelSize;

			color c = movie.get(x, y);
			fill(c);
			stroke(c);
			rect(x, y, newPixelSize, newPixelSize);

		}

	}

}

boolean sketchFullScreen() {
	return isFullscreen;
}