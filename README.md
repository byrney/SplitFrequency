
Split Frequency
===============

A shell script and Mac app that uses [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/)
 and [ImageMagick](http://www.imagemagick.org/) to take a jpeg and
generate a PSD file with 3 layers that can be opened in Pixelmator

* LF: a blurred (low frequency) version of the original
* HF: the detail (high frequencey) which when combined with LF will recreate the original
* Original: the original image

I use this with [Raw Photo Processor (RPP)](http://www.raw-photo-processor.com/) to
automatically generate a PSD which I then refine 
by hand in [Pixelmator](http://www.pixelmator.com/).  Note, photoshop is not required.

Common things to do are:

* Use a healing brush on the HF layer to remove blemishes without affecting colour
* Smudge or paint on the LF layer to smooth out colour differences without affecting details
* Add a layer mask to HF and increase opacity to selectively sharpen

more tips (along with steps to do the split manually) can be found [here](http://omahaimageproductions.com/blog/2012/02/skin-retouching-technique-frequency-separation/)


Operation
=========

**To run the script standalone**

Run the script and pass a jpeg filename

		bash photo-splitfreq.sh input.jpg

the input file will NOT be changed. A file called input.psd will be generated in the same folder.

**To run the application**

To use the App just drop a file onto the application or set it as an output option in RPP. The input
file WILL BE DELETED when using the app.

The resulting PSD has three layers but stll requires a little adjustment manually in
Photoshop or Pixelmator

1. Hide the original layer to make HF visible
2. Set the blend mode of HF to 'Linear Light'
3. Set the opacity of HF to 50%

The result of HF + LF should look exactly the same as original (which is now invisible).
Adjust the opacity of HF to taste for a sharper image

Prerequisites
=============

install ImageMagick and exiftool.

The easiest way to do this is using [homebrew](www.brew.sh):

	brew install exiftool
	brew install imagemagick

the app expects to find these in /usr/local/bin which is where brew puts them by default.

Building
===========

in the project directory run

	rake

to build the app.  You should now have a SplitFrequency.app in that directory. Copy
it to /Applications or run

    rake install

to put it in the current users local Applications folder.

Compatibility / Caveats
=======================

I only use this on OSX Mavericks (10.9) so it doesn't get tested anywhere else.

The Application obviously only works on OSX but there's no reason the script
wouldn't work on any machine with bash, imagemagick and exiftool installed.

The blur applied to generate the LF layer is fixed. In practice this is something
that should be tuned for the image in question. The current value works well
for head shots but not so well for, say, landscapes. Modifying the script is the only way to adjust it
currently

Having to manually change the blend mode and opacity is annoying but I couldn't find a 
way to write the PSD with those values included.

