Class {
	#name : #DoubleCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DoubleCard class >> create [

	^ self new initializeAs: InstantaneousCard new
]

{ #category : #playing }
DoubleCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	InstantaneousCard new incorporate: self to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
DoubleCard class >> playOnceIn: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame repeatActualTurn.
]

{ #category : #initialization }
DoubleCard >> = aCard [

	^ self class = aCard
]

{ #category : #assertion }
DoubleCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #assertion }
DoubleCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion.
]

{ #category : #initialization }
DoubleCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]
