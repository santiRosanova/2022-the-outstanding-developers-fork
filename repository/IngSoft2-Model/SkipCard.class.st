Class {
	#name : #SkipCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SkipCard class >> create [

	^ self new initializeAs: InstantaneousCard new
]

{ #category : #playing }
SkipCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	InstantaneousCard new incorporate: self to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
SkipCard class >> playOnceIn: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame skipActualTurn
]

{ #category : #initialization }
SkipCard >> = aCard [

	^ self class = aCard
]

{ #category : #assertion }
SkipCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #assertion }
SkipCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion.
]

{ #category : #initialization }
SkipCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]
