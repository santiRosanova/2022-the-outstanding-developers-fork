Class {
	#name : #OutstandingSpaceshipsGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice',
		'stateOfGame',
		'spaceshipsCardDeck',
		'spaceshipsPlaying',
		'spaceshipsAffectingCardDeck',
		'lastPlayedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
OutstandingSpaceshipsGame class >> assertValidNumberOfSpaceshipsIsGreaterThanZero: spaceships [

	spaceships isEmpty ifTrue: [ 
		Error signal: 'Must use at least one spaceship' ]
]

{ #category : #assertion }
OutstandingSpaceshipsGame class >> assertValidSpaceships: spaceships [

	self assertValidNumberOfSpaceshipsIsGreaterThanZero: spaceships.
	self assertValidSpaceshipsAsigneesAreNotRepeated: spaceships
]

{ #category : #assertion }
OutstandingSpaceshipsGame class >> assertValidSpaceshipsAsigneesAreNotRepeated: spaceships [

	| uniqueSpaceships |
	uniqueSpaceships := spaceships asOrderedCollection removeDuplicates
		                    asArray.
	spaceships size = uniqueSpaceships size ifFalse: [ 
		Error signal: 'Spaceships must be assigned to different players' ]
]

{ #category : #'instance creation' }
OutstandingSpaceshipsGame class >> playedBy: spaceship on: aBoard throwing: dice using: aCardDistribution [

	^ self
		  playedByMany: { spaceship }
		  on: aBoard
		  throwing: dice
		  using: aCardDistribution
]

{ #category : #'instance creation' }
OutstandingSpaceshipsGame class >> playedByMany: spaceships on: aBoard throwing: dice using: aCardDistribution [

	self assertValidSpaceships: spaceships.
	^ self new
		  initializeWith: aBoard
		  many: spaceships
		  throwing: dice
		  using: aCardDistribution
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addAffecting: aSpaceshipCardHolder [
	
	lastPlayedCard := aSpaceshipCardHolder card.
	spaceshipsAffectingCardDeck add: aSpaceshipCardHolder
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addAffectingAll: aCard [

	lastPlayedCard := aCard.
	spaceshipsPlaying do: [ :spaceship | 
		self addAffecting:
			(SpaceshipCardHolder of: spaceship holding: aCard) ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addHolding: aSpaceshipCardHolder [

	spaceshipsCardDeck add: aSpaceshipCardHolder
]

{ #category : #assertion }
OutstandingSpaceshipsGame >> assertCardBelongsToSpaceship: cardPosition [

	cardPosition = 0 ifTrue: [ 
		Error signal: 'The spaceship doesnt have cards to throw' ]
]

{ #category : #assertion }
OutstandingSpaceshipsGame >> assertCardCanBeRemoved: aCardPosition [

	aCardPosition = 0 ifTrue: [ 
		Error signal:
			'Cancellation card cant be used if the chosen card is not in game' ]
]

{ #category : #assertion }
OutstandingSpaceshipsGame >> assertCardCanBeThrown: aCard from: aSpaceship [

	board assertACardCanBeThrown.
	aCard
		assertItIsThrowableInTurn: (board isSpaceshipsTurn: aSpaceship)
		in: self
]

{ #category : #playing }
OutstandingSpaceshipsGame >> cancel: aCard affecting: aSpaceship [

	| cardToBeRemoved |
	cardToBeRemoved := spaceshipsAffectingCardDeck findFirst: [ 
		                   :spaceshipAffectingCardDeck | 
		                   spaceshipAffectingCardDeck spaceship = aSpaceship 
			                   and: [ 
			                   spaceshipAffectingCardDeck card name = aCard name ] ].
	self assertCardCanBeRemoved: cardToBeRemoved.
	lastPlayedCard := CancellationCard create.
	spaceshipsAffectingCardDeck removeAt: cardToBeRemoved
]

{ #category : #playing }
OutstandingSpaceshipsGame >> cancelAll: cardType [

	spaceshipsPlaying do: [ :spaceship | 
		self cancel: cardType affecting: spaceship ].
	lastPlayedCard := CancellationCard create
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> cardsAffectingOf: aSpaceship [

	^ spaceshipsAffectingCardDeck select: [ :spaceshipCardDeck | 
		  spaceshipCardDeck spaceship = aSpaceship ]
]

{ #category : #properties }
OutstandingSpaceshipsGame >> countActivePermanentCards [

	^ spaceshipsAffectingCardDeck count: [ :spaceshipAffectingCardDeck | 
		  spaceshipAffectingCardDeck card typeOfCard = 'Permanent' ]
]

{ #category : #setup }
OutstandingSpaceshipsGame >> dealWith: aCardDistribution [

	| cardGenerator |
	cardGenerator := RandomEventGenerator
		                 with: 1
		                 using: aCardDistribution.
	spaceshipsCardDeck := OrderedCollection new.
	spaceshipsPlaying do: [ :spaceship | 
		2 timesRepeat: [ 
			spaceshipsCardDeck add: (SpaceshipCardHolder
					 of: spaceship
					 holding: (cardGenerator generate at: 1)) ] ]
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> deckOf: aSpaceship [

	^ spaceshipsCardDeck select: [ :spaceshipCardDeck | 
		  spaceshipCardDeck spaceship = aSpaceship ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> free: aSpaceship [

	board free: aSpaceship.
	lastPlayedCard := FreedomCard create
]

{ #category : #initialization }
OutstandingSpaceshipsGame >> initializeWith: aBoard many: spaceships throwing: someDice using: aCardDistribution [

	lastPlayedCard := ''.
	board := aBoard.
	aBoard playingWith: spaceships in: self.
	spaceshipsPlaying := spaceships.
	dice := someDice.
	aBoard maxDiceRollResult: self maxDiceRollResult.
	stateOfGame := GameNotWonState new.
	spaceshipsAffectingCardDeck := OrderedCollection new.
	self dealWith: aCardDistribution
]

{ #category : #playing }
OutstandingSpaceshipsGame >> invertTurnsOrder [

	board invertTurnsOrder.
	lastPlayedCard := ReverseCard create
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> lastPlayedCard [

	^ lastPlayedCard
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> maxDiceRollResult [

	^ dice maxRollResult
]

{ #category : #playing }
OutstandingSpaceshipsGame >> play [

	stateOfGame play: self
]

{ #category : #playing }
OutstandingSpaceshipsGame >> playTurn [
	| resultOfTheRoll deckOfSpaceship effectOnDiceThrow |
	resultOfTheRoll := dice roll.
	deckOfSpaceship := self cardsAffectingOf: board spaceshipPlaying.
	deckOfSpaceship isEmpty
		ifTrue: [ effectOnDiceThrow := 0 ]
		ifFalse: [ effectOnDiceThrow := deckOfSpaceship
				sum: [ :cardHolder | cardHolder effectOnThrow ] ].
	board moveSpaceship: resultOfTheRoll + effectOnDiceThrow.
	board thereIsAWinner
		ifTrue: [ stateOfGame := GameWonState new ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> repeatActualTurn [

	board repeatActualTurn.
	lastPlayedCard := DoubleCard create
]

{ #category : #playing }
OutstandingSpaceshipsGame >> repeatEffectOn: aSpaceship [

	board lastBox effect reApplyEffectTo: aSpaceship on: board.
	lastPlayedCard := RepeatCard create
]

{ #category : #playing }
OutstandingSpaceshipsGame >> skipActualTurn [

	board skipActualTurn.
	lastPlayedCard := SkipCard create
	
]

{ #category : #playing }
OutstandingSpaceshipsGame >> startSimulation [

	[ self thereIsAWinner ] whileFalse: [ self playTurn ]
]

{ #category : #results }
OutstandingSpaceshipsGame >> thereIsAWinner [

	^ stateOfGame isFinished
]

{ #category : #'card throwing' }
OutstandingSpaceshipsGame >> throws: aCard from: aSpaceship [

	| cardToBeRemoved |
	cardToBeRemoved := spaceshipsCardDeck findFirst: [ :spaceshipCardDeck | 
		                   spaceshipCardDeck spaceship = aSpaceship and: [ 
			                   spaceshipCardDeck card = aCard ] ].
	self assertCardBelongsToSpaceship: cardToBeRemoved.
	self
		assertCardCanBeThrown: (spaceshipsCardDeck at: cardToBeRemoved) card
		from: aSpaceship.
	aCard incorporateTo: self.
	spaceshipsCardDeck removeAt: cardToBeRemoved.
]

{ #category : #results }
OutstandingSpaceshipsGame >> winner [

	^ board winner
]
