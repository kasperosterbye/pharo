"
The class `AthensBalloonImagePaint` is a subclass of `AthensPaint` and is used to define a paint that fills shapes with a balloon image. The balloon image is defined by a form, which is a bitmap representation of the image. The paint can be configured with an origin point, a direction vector, and a tile flag. The origin point defines the starting point of the image, the direction vector defines the direction in which the image should be stretched, and the tile flag determines whether the image should be tiled when filling a shape.

The class provides methods for accessing and setting the form, origin, and direction of the paint, as well as a method for calculating the normal vector of the paint. The normal vector is used to determine the direction in which the image should be stretched when filling a shape.

The class also provides methods for rendering the paint on a canvas. The `athensFillPath:on:` method is used to fill a path with the balloon image, and the `athensFillRectangle:on:` method is used to fill a rectangle with the balloon image. These methods use the Athens rendering engine to register the form fill and then fill the shape with the registered form.

Overall, the `AthensBalloonImagePaint` class provides a flexible and powerful way to fill shapes with balloon images in the Athens rendering framework.
"
Class {
	#name : 'AthensBalloonImagePaint',
	#superclass : 'AthensPaint',
	#instVars : [
		'form',
		'origin',
		'direction',
		'tileFlag'
	],
	#category : 'Athens-Balloon-Paint',
	#package : 'Athens-Balloon',
	#tag : 'Paint'
}

{ #category : 'rendering' }
AthensBalloonImagePaint >> athensFillPath: aPath on: anAthensCanvas [

	anAthensCanvas surface engine
		prepareForRendering;
		registerFormFill: form origin: origin direction: direction normal: self normal;
		fillBezierShape: aPath contoursForFilling
]

{ #category : 'rendering' }
AthensBalloonImagePaint >> athensFillRectangle: aRect on: anAthensCanvas [
	"This is a terminal method in rendering dispatch scheme
	canvas->shape->paint. See AthensCanvas>>fillShape: "
	|rotation normal|
	rotation := anAthensCanvas surface paintTransform transform: direction.
	normal := anAthensCanvas surface paintTransform transform:self normal.


	anAthensCanvas surface engine reset
		prepareForRendering;
		registerFormFill: form origin: origin direction: rotation normal: normal tileFlag: tileFlag;
		fillRectangle: aRect
]

{ #category : 'accessing' }
AthensBalloonImagePaint >> direction [

	^ direction
]

{ #category : 'accessing' }
AthensBalloonImagePaint >> direction: anObject [

	direction := anObject
]

{ #category : 'accessing' }
AthensBalloonImagePaint >> form [

	^ form
]

{ #category : 'accessing' }
AthensBalloonImagePaint >> form: anObject [

	form := anObject.
	origin := 0@0.
	direction := form extent x @0
]

{ #category : 'initialization' }
AthensBalloonImagePaint >> initialize [
	super initialize.

	direction := 0 @ 0.
	origin := 0 @ 0.
	tileFlag := false
]

{ #category : 'accessing' }
AthensBalloonImagePaint >> normal [

	^ (direction y negated @ direction x * form height / form width) rounded
]

{ #category : 'accessing' }
AthensBalloonImagePaint >> origin [

	^ origin
]

{ #category : 'accessing' }
AthensBalloonImagePaint >> origin: anObject [

	origin := anObject
]

{ #category : 'accessing' }
AthensBalloonImagePaint >> repeat [

	tileFlag := true
]
