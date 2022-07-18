Class {
	#name : #ReverseCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ReverseCard class >> create [

	^ self new initializeAs: InstantaneousCard new
]

{ #category : #playing }
ReverseCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	InstantaneousCard new incorporate: self to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
ReverseCard class >> playOnceIn: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame invertTurnsOrder
]

{ #category : #initialization }
ReverseCard >> = aCard [

	^ self class = aCard
]

{ #category : #asserting }
ReverseCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #asserting }
ReverseCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion.
]

{ #category : #accessing }
ReverseCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #playing }
ReverseCard >> incorporate: aCard to: anOutstandingSpaceshipsGame [ 
	
	self cardBehaviour incorporate: aCard to: anOutstandingSpaceshipsGame 
]

{ #category : #playing }
ReverseCard >> incorporateTo: anOutstandingSpaceshipsGame the: cardElement [

	anOutstandingSpaceshipsGame invertTurnsOrder.
]

{ #category : #initialization }
ReverseCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]
