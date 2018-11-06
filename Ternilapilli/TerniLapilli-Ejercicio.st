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

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/5/2018 20:13:37'!
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
			self assert: error messageText equals: ternidor cantMoveTwice .
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


!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board emptyBoard xs lastPlayer chips gameOver winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'evaluate' stamp: 'mc 11/5/2018 14:15:27'!
isEmpty
	^emptyBoard .! !

!TerniLapilli methodsFor: 'evaluate' stamp: 'A 11/5/2018 20:38:39'!
isOver

	^gameOver! !

!TerniLapilli methodsFor: 'evaluate' stamp: 'A 11/5/2018 20:38:56'!
winner

	^winner.! !


!TerniLapilli methodsFor: 'accessing' stamp: 'A 11/5/2018 18:46:12'!
at: aPoint

	^board at: aPoint .! !

!TerniLapilli methodsFor: 'accessing' stamp: 'A 11/5/2018 21:16:38'!
hasWon: aChip after: aPoint

	^(board at: aPoint = aChip) and: [(board at: aPoint = aChip) and: [board at: aPoint = aChip]].! !

!TerniLapilli methodsFor: 'accessing' stamp: 'A 11/5/2018 20:49:27'!
move: aChip from: fromPoint to: toPoint

	self validateMovefor: aChip  from: fromPoint to: toPoint .
	board at: fromPoint put: nil.
	board at: toPoint put: aChip.
	lastPlayer := aChip.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'A 11/5/2018 20:58:28'!
put: aChip at: aPoint 

	emptyBoard ifTrue: 
	[
		"first Play"
		emptyBoard _ false.
	] ifFalse: 
	[
		self validatePutfor: aChip and: aPoint .
		
		"sino juego"
	].

		board at: aPoint put: aChip.
		lastPlayer := aChip.
		chips _ chips +1.		
! !


!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 19:39:29'!
cantFitMoreChips
	^'Los jugadores no pueden colocar mas fichas, ahora deben mover'.! !

!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 20:04:24'!
cantMoveToPositionAlreadyTaken

	^'No se puede mover a una posición ya ocupada.'! !

!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 20:18:32'!
cantMoveTwice
	
		^'Jugador no puede mover dos veces seguidas.'! !

!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 20:44:56'!
gameOver

	^'El juego termino'.! !

!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 19:22:59'!
playerCantPlayTwiceInARowErrorMessage
	^'El jugador no puede jugar dos veces seguidas'.! !

!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 19:22:10'!
positionAlreadyTakenErrorMessage

	^'La posicion ya se encuentra ocupada'.! !


!TerniLapilli methodsFor: 'private' stamp: 'A 11/5/2018 20:50:56'!
validateMovefor: aChip from: fromPoint to: toPoint

	(board at: toPoint) ifNotNil: [self error: self cantMoveToPositionAlreadyTaken.].
	lastPlayer = aChip ifTrue: [self error: self cantMoveTwice.].! !

!TerniLapilli methodsFor: 'private' stamp: 'A 11/5/2018 20:48:17'!
validatePutfor: aChip and: aPoint

	"Control plays other player"
		lastPlayer = aChip ifTrue: [self error: self playerCantPlayTwiceInARowErrorMessage ].
		"Cant put in a occupied slot (?)"
		(board at: aPoint) ifNotNil: [self error: self positionAlreadyTakenErrorMessage ].
		"tablero lleno"
		chips = 6 ifTrue:[self error: self cantFitMoreChips].
		"si termino no aceptar mas movimientos"
		gameOver ifTrue:[ self error: self gameOver].! !


!TerniLapilli methodsFor: 'initialize' stamp: 'A 11/5/2018 20:58:37'!
initialize

	board _ Array2D height: 3 width:3. 
	emptyBoard _ true.
	gameOver _ false.
	chips := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'instance creation' stamp: 'mc 11/5/2018 14:03:38'!
newGame
	
	^self new initialize.! !
