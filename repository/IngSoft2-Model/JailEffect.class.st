Class {
	#name : #JailEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
JailEffect class >> create [

	^ self new
]

{ #category : #effects }
JailEffect >> applyEffectOn: aBoard [

	^ self effectOnPosition
]

{ #category : #effects }
JailEffect >> effectOn: aBoard to: aSpaceship [ 

	aBoard addToJail: aSpaceship
]

{ #category : #effects }
JailEffect >> effectOnPosition [

	^ 0
]
