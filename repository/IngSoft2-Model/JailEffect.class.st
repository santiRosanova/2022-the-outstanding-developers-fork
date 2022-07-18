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
JailEffect >> effectOnPosition [

	^ 0
]

{ #category : #effects }
JailEffect >> effectOnTheGame [

	^ 'Add to Jail'
]
