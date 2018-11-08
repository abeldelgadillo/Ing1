!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Ejercicio'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliTest methodsFor: 'test' stamp: 'mc 11/5/2018 14:04:30'!
test01

	"al inicio de un nuevo juego el mismo debe estar vacio"
	
	| ternidor | 
	
	ternidor  _ TerniLapilli new.
	
	self assert:  (ternidor isEmpty).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'mc 11/5/2018 14:05:04'!
test02

	"Al colocar una ficha el juego ya no esta vacio y la posicion esta ocupada"
	
	| ternidor |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	
	self deny:  ternidor isEmpty.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/5/2018 19:24:04'!
test03

	"No puede jugar el jugador X dos veces seguidas."
	
	| ternidor |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	
	self 
		should: [ternidor put:'X' at:(2@1).]
		raise: Error
		withExceptionDo: [:error|
			self assert: error messageText equals: ternidor playerCantPlayTwiceInARowErrorMessage .
			]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/5/2018 18:45:28'!
test04

	"Juegan X y luego O"
	
	| ternidor |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	ternidor put:'O' at:(2@1).
	
	self deny:  ternidor isEmpty.
	self assert: (ternidor at:(1@1)) equals: 'X'.
	self assert: (ternidor at:(2@1)) equals: 'O'.
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/5/2018 19:23:50'!
test05

	"Juegan X y luego O quiere jugar en la misma posicion que X"
	
	| ternidor |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	
	self 
		should: [ternidor put:'O' at:(1@1).]
		raise: Error
		withExceptionDo: [:error|
			self assert: error messageText equals: ternidor positionAlreadyTakenErrorMessage.
			]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/5/2018 19:31:52'!
test06

	" Poner en una posicion no valida deberia tirar un error (alguno) "
	
	| ternidor |
	
	ternidor _ TerniLapilli newGame.
		
	self 
		should: [ternidor put:'O' at:(4@1).]
		raise: Error.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/5/2018 19:45:14'!
test07

	"cuando ya tengo tres fichas de cada uno no puedo poner mas"
	
	
	| ternidor |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	ternidor put:'O' at:(2@1).
	ternidor put:'X' at:(3@1).
	ternidor put:'O' at:(1@2).
	ternidor put:'X' at:(1@3).
	ternidor put:'O' at:(2@2).
	
	self 
		should: [ternidor put:'X' at:(3@3)]
		raise: Error
		withExceptionDo: [:error|
			self assert: error messageText equals: ternidor cantFitMoreChips .
			]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/5/2018 19:57:26'!
test08

	"cuando ya tengo tres fichas de cada uno muevo como plebeyo"
	
	
	| ternidor  from to |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	ternidor put:'O' at:(2@1).
	ternidor put:'X' at:(3@1).
	ternidor put:'O' at:(1@2).
	ternidor put:'X' at:(1@3).
	ternidor put:'O' at:(2@2).
	
	from _ (3@1).
	to _ (3@2).
	ternidor  move:'X' from:from to:to.
	
	self assert: (ternidor at: from) equals: nil.
	self assert: (ternidor at: to) equals: 'X'.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/5/2018 20:01:39'!
test09

	"muevo a una posicion ya ocupada"
	
	
	| ternidor  from to |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	ternidor put:'O' at:(2@1).
	ternidor put:'X' at:(3@1).
	ternidor put:'O' at:(1@2).
	ternidor put:'X' at:(1@3).
	ternidor put:'O' at:(2@2).
	
	from _ (1@1).
	to _ (2@1).
	
	self 
		should: [ternidor  move:'X' from:from to:to.]
		raise: Error
		withExceptionDo: [:error|
			self assert: error messageText equals: ternidor cantMoveToPositionAlreadyTaken .
			]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'mc 11/8/2018 00:39:34'!
test10

	"Jugador no puede mover dos veces"
	
	
	| ternidor  from to |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	ternidor put:'O' at:(2@1).
	ternidor put:'X' at:(3@1).
	ternidor put:'O' at:(1@2).
	ternidor put:'X' at:(1@3).
	ternidor put:'O' at:(2@2).
	
	from _ (3@1).
	to _ (3@2).
	ternidor  move:'X' from:from to:to.
	
	from := to.
	to := (3@3).
	self 
		should: [ternidor  move:'X' from:from to:to.]
		raise: Error
		withExceptionDo: [:error|
			self assert: error messageText equals: ternidor playerCantPlayTwiceInARowErrorMessage .
			]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/5/2018 20:36:45'!
test11

	"pone tres en vertical gana, el juego se termina, no se aceptan mas movimientos"
	
	
	| ternidor  |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	ternidor put:'O' at:(1@2).
	ternidor put:'X' at:(2@1).
	ternidor put:'O' at:(2@2).
	ternidor put:'X' at:(3@1).

	self assert: ternidor isOver.
	self assert: (ternidor winner) equals:'X'.
	self should:[ternidor put:'O' at:(2@3).]
		raise:Error.
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/7/2018 16:25:01'!
test12

	"Jugador X obtiene tres en vertical luego de mover y gana, el juego se termina, no se aceptan mas movimientos"
	
	
	| ternidor  |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	ternidor put:'O' at:(1@2).
	ternidor put:'X' at:(2@1).
	ternidor put:'O' at:(2@2).
	ternidor put:'X' at:(3@2).
	ternidor put:'O' at:(3@3).

	ternidor move:'X' from: (3@2) to:(3@1).

	self assert: ternidor isOver.
	self assert: (ternidor winner) equals:'X'.
	self should:[ternidor move:'O' from: (2@2) to:(2@3).]
		raise:Error
		withExceptionDo: [:error|
			self assert: error messageText equals: ternidor gameOver .
			]! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board lastPlayer chips winner state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'evaluate' stamp: 'A 11/7/2018 15:59:42'!
hasWon: aChip 
	
	^( (board at: 1@1) = aChip and: [(board at: 2@1) = aChip and: [(board at: 3@1) = aChip]] ) or: 
	[( (board at: 1@2) = aChip and: [(board at: 2@2) = aChip and: [(board at: 3@2) = aChip]] ) or: 
	[( (board at: 1@3) = aChip and: [(board at: 2@3) = aChip and: [(board at: 3@3) = aChip]] ) or: 
	[( (board at: 1@1) = aChip and: [(board at: 1@2) = aChip and: [(board at: 1@3) = aChip]] ) or: 
	[( (board at: 2@1) = aChip and: [(board at: 2@2) = aChip and: [(board at: 2@3) = aChip]] ) or: 
	[( (board at: 3@1) = aChip and: [(board at: 3@2) = aChip and: [(board at: 3@3) = aChip]] ) or: 
	[( (board at: 1@1) = aChip and: [(board at: 2@2) = aChip and: [(board at: 3@3) = aChip]] ) or: 
	[( (board at: 1@3) = aChip and: [(board at: 2@2) = aChip and: [(board at: 3@1) = aChip]] ) ]]]]]]].! !

!TerniLapilli methodsFor: 'evaluate' stamp: 'mc 11/8/2018 00:44:44'!
isEmpty
	^state isEmpty .! !

!TerniLapilli methodsFor: 'evaluate' stamp: 'mc 11/8/2018 00:44:53'!
isOver

	^state isOver! !

!TerniLapilli methodsFor: 'evaluate' stamp: 'A 11/5/2018 20:38:56'!
winner

	^winner.! !


!TerniLapilli methodsFor: 'accessing' stamp: 'A 11/5/2018 18:46:12'!
at: aPoint

	^board at: aPoint .! !

!TerniLapilli methodsFor: 'accessing' stamp: 'mc 11/7/2018 22:45:19'!
move: aChip from: fromPoint to: toPoint

	self validateTurnFor: aChip.
	state move: aChip from: fromPoint to: toPoint  on: self.
	"
	self validateMovefor: aChip  from: fromPoint to: toPoint .
	board at: fromPoint put: nil.
	board at: toPoint put: aChip.
	lastPlayer := aChip.
	
	(self hasWon: aChip) ifTrue: 
	[
		gameOver := true.
		winner := aChip.
		]
"! !

!TerniLapilli methodsFor: 'accessing' stamp: 'mc 11/7/2018 22:45:46'!
put: aChip at: aPoint 

	self validateTurnFor: aChip.
	state put: aChip  at: aPoint on: self. 
	"
	emptyBoard ifTrue: 
	[
		-first Play-
		emptyBoard _ false.
	] ifFalse: 
	[
		self validatePutfor: aChip and: aPoint .
		
		-sino juego-
	].

	board at: aPoint put: aChip.
	lastPlayer := aChip.
	chips _ chips +1.	
		
	(self hasWon: aChip) ifTrue: 
	[
		gameOver := true.
		winner := aChip.
		]
"! !


!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 19:39:29'!
cantFitMoreChips
	^'Los jugadores no pueden colocar mas fichas, ahora deben mover'.! !

!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 20:04:24'!
cantMoveToPositionAlreadyTaken

	^'No se puede mover a una posición ya ocupada.'! !

!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 20:44:56'!
gameOver

	^'El juego termino'.! !

!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 19:22:59'!
playerCantPlayTwiceInARowErrorMessage
	^'El jugador no puede jugar dos veces seguidas'.! !

!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 19:22:10'!
positionAlreadyTakenErrorMessage

	^'La posicion ya se encuentra ocupada'.! !


!TerniLapilli methodsFor: 'private' stamp: 'mc 11/7/2018 22:32:20'!
controlIfLastMoveWins

	(self hasWon: lastPlayer ) ifTrue: 
	[
		state _ TerniLapilliOverState new.
		winner := lastPlayer .
		]! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/7/2018 22:46:41'!
validateMovefor: aChip from: fromPoint to: toPoint

	(board at: toPoint) ifNotNil: [self error: self cantMoveToPositionAlreadyTaken.].! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/7/2018 22:35:30'!
validatePutfor: aChip and: aPoint

		"Cant put in a occupied slot (?)"
		(board at: aPoint) ifNotNil: [self error: self positionAlreadyTakenErrorMessage ].

! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/8/2018 00:39:12'!
validateTurnFor: aChip

	lastPlayer = aChip ifTrue: [self error: self playerCantPlayTwiceInARowErrorMessage.]! !


!TerniLapilli methodsFor: 'initialize' stamp: 'mc 11/7/2018 20:12:56'!
initialize

	board _ Array2D height: 3 width:3. 
	emptyBoard _ true.
	gameOver _ false.
	chips := 0.
	state _ TerniLapilliStartState new.! !


!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'mc 11/7/2018 20:24:39'!
changeToOccupy

	emptyBoard _ false.
	state _ TerniLapilliVacantState new.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'mc 11/7/2018 22:19:11'!
mxxx: aChip  from: fromPoint to: toPoint
 
	board at: fromPoint put: nil.
	board at: toPoint put: aChip.
	lastPlayer := aChip.
	self controlIfLastMoveWins.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'mc 11/7/2018 22:19:30'!
xxx: aChip  put: aPoint
 
	board at: aPoint put: aChip.
	lastPlayer := aChip.
	chips _ chips +1.
	" esto no se si deberia estar aca deberia manejarlo el state "
	chips = 6 ifTrue: [state _ TerniLapilliMovingState new].
	self controlIfLastMoveWins.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'instance creation' stamp: 'mc 11/5/2018 14:03:38'!
newGame
	
	^self new initialize.! !


!classDefinition: #TerniLapilliState category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 00:46:49'!
isEmpty

	^false! !

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 00:46:05'!
isOver

	^false! !


!classDefinition: #TerniLapilliMovingState category: #'TerniLapilli-Ejercicio'!
TerniLapilliState subclass: #TerniLapilliMovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliMovingState methodsFor: 'as yet unclassified' stamp: 'mc 11/7/2018 21:36:55'!
move: aChip from: fromPoint to: toPoint on: aTerniLapilli 
	
	aTerniLapilli validateMovefor: aChip  from:  fromPoint to: toPoint.
	aTerniLapilli  mxxx: aChip from: fromPoint to: toPoint.! !

!TerniLapilliMovingState methodsFor: 'as yet unclassified' stamp: 'mc 11/7/2018 20:44:40'!
put: aChip at: aPoint on: aTerniLapilli

	self error: aTerniLapilli cantFitMoreChips! !


!classDefinition: #TerniLapilliOverState category: #'TerniLapilli-Ejercicio'!
TerniLapilliState subclass: #TerniLapilliOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliOverState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 00:46:25'!
isOver

	^true.! !

!TerniLapilliOverState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 01:01:06'!
move: aChip from: fromPoint to: toPoint on: aTerniLapilli 
	
	self error: aTerniLapilli gameOver! !

!TerniLapilliOverState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 01:01:10'!
put: aChip at: aPoint on: aTerniLapilli

	self error: aTerniLapilli gameOver! !


!classDefinition: #TerniLapilliStartState category: #'TerniLapilli-Ejercicio'!
TerniLapilliState subclass: #TerniLapilliStartState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliStartState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 00:47:16'!
isEmpty

	^true.! !

!TerniLapilliStartState methodsFor: 'as yet unclassified' stamp: 'mc 11/7/2018 22:20:04'!
put: aChip at: aPoint on: aTerniLapilli

	
	aTerniLapilli xxx: aChip put: aPoint.
	aTerniLapilli changeToOccupy.! !


!classDefinition: #TerniLapilliVacantState category: #'TerniLapilli-Ejercicio'!
TerniLapilliState subclass: #TerniLapilliVacantState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliVacantState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 01:01:36'!
put: aChip at: aPoint on: aTerniLapilli

	aTerniLapilli validatePutfor: aChip and: aPoint.
	aTerniLapilli xxx: aChip put: aPoint.! !
