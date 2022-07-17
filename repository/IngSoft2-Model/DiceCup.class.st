Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceCup class >> withAll: dice [

	^ self new initializeWithAll: dice
]

{ #category : #initialization }
DiceCup >> initializeWithAll: aDice [
 
	dice := aDice
]

{ #category : #accessing }
DiceCup >> maxRollResult [

	^ dice inject: 0 into: [ :a :b | a + (b maxRollResult) ]
]

{ #category : #rolling }
DiceCup >> roll [

	^ dice sum: [ :die | die roll ]
]
