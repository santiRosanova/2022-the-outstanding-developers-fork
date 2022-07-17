Class {
	#name : #FreedomCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#classInstVars : [
		'spaceship',
		'cardType'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
FreedomCard class >> create [

	^ self new initializeAs: InstantaneousCard new
]

{ #category : #playing }
FreedomCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	InstantaneousCard new incorporate: self to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
FreedomCard class >> playOnceIn: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame free: spaceship
]

{ #category : #'class initialization' }
FreedomCard class >> thrownAt: aSpaceship [

	spaceship := aSpaceship.
	cardType := InstantaneousCard
]

{ #category : #initialization }
FreedomCard >> = aCard [

	^ self class = aCard
]

{ #category : #assertion }
FreedomCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #asserting }
FreedomCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion.
]

{ #category : #initialization }
FreedomCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]
