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

{ #category : #accessing }
SkipCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #playing }
SkipCard >> incorporate: aCard to: anOutstandingSpaceshipsGame [ 
	
	self cardBehaviour incorporate: aCard to: anOutstandingSpaceshipsGame 
]

{ #category : #playing }
SkipCard >> incorporateTo: anOutstandingSpaceshipsGame the: cardElement [

	anOutstandingSpaceshipsGame skipActualTurn.
]

{ #category : #initialization }
SkipCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]
