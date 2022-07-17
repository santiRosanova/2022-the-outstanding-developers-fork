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
JailEffect >> effectOnAThrowOf: aNumber [ 
	
	^ (aNumber * -1)
]

{ #category : #effects }
JailEffect >> effectOnPosition [

	^ 0
]
