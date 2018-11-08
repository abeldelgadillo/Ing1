!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Ejercicio'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:17:07'!
test01JuegoSeIniciaConTableroVacio
	
	| ternidor | 
	
	ternidor  _ TerniLapilli new.
	
	self assert:  (ternidor isEmpty).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:17:45'!
test02TableroNoEstaVacioLuegoDeColocarUnaFicha
	
	| ternidor |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	
	self deny:  ternidor isEmpty.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:11:47'!
test03JugadorNoPuedeJugarDosVecesSeguidas
	
	| ternidor |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	
	self 
		should: [ternidor put:'X' at:(2@1).]
		raise: Error
		withExceptionDo: [:error|
			self assert: error messageText equals: ternidor playerCantPlayTwiceInARowErrorMessage .
			]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:18:20'!
test04XyOJueganPorTurnos

	"Juegan X y luego O y todo esta bien"
	
	| ternidor |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	ternidor put:'O' at:(2@1).
	
	self deny:  ternidor isEmpty.
	self assert: (ternidor at:(1@1)) equals: 'X'.
	self assert: (ternidor at:(2@1)) equals: 'O'.
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:11:44'!
test05NoSePuedeColocarFichaEnPosicionOcupada

	| ternidor |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	
	self 
		should: [ternidor put:'O' at:(1@1).]
		raise: Error
		withExceptionDo: [:error|
			self assert: error messageText equals: ternidor cantPutIntoAPositionAlreadyTakenErrorMessage.
			]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:11:41'!
test06NoSePuedeColocarFichaEnPosicionInvalida

	| ternidor |
	
	ternidor _ TerniLapilli newGame.
		
	self 
		should: [ternidor put:'O' at:(4@1).]
		raise: Error.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:11:38'!
test07NoPuedeHaberMasDeTresFichasPorJugadorEnTablero
	
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
			self assert: error messageText equals: ternidor notMoreChipsErrorMessage .
			]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:19:09'!
test08SiAlMenosUnJugadorNoTieneTresFichasEnTableroNoSePuedeMoverFichas
	
	| ternidor  from to |
	
	ternidor _ TerniLapilli newGame.
	
	ternidor put:'X' at:(1@1).
	ternidor put:'O' at:(2@1).

	
	from _ (3@1).
	to _ (3@2).
	

	self 
		should: [ternidor  move:'X' from:from to:to.]
		raise: Error
		withExceptionDo: [
			:error | self assert: error messageText equals: ternidor notEnoughChipsToStartMoveErrorMessage.
			]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:20:13'!
test09JugadorMueveFicha

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

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:12:09'!
test10NoSePuedeMoverAPosicionOcupada
		
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
			self assert: error messageText equals: ternidor cantMoveToPositionAlreadyTakenErrorMessage .
			]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:15:04'!
test11JugadorNoPuedeMoverDosVecesSeguidas	
	
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

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:15:33'!
test12SiElJuegoSeTerminaNoSePuedePonerFichas
		
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

!TerniLapilliTest methodsFor: 'test' stamp: 'A 11/8/2018 14:16:11'!
test13SiElJuegoSeTerminaNoSePuedeMoverFichas
		
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
			self assert: error messageText equals: ternidor gameOverNoMorePlaysErrorMessage .
			]! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board lastPlayer chips winner state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'evaluate' stamp: 'mc 11/8/2018 02:17:55'!
hasWon: aChip 
	
	^(self controlVerticalLinesFor: aChip) or:[(self controlHorizontalLinesFor: aChip) or:[self controlDiagonalsFor: aChip].] ! !

!TerniLapilli methodsFor: 'evaluate' stamp: 'mc 11/8/2018 00:44:44'!
isEmpty
	^state isEmpty .! !

!TerniLapilli methodsFor: 'evaluate' stamp: 'mc 11/8/2018 00:44:53'!
isOver

	^state isOver! !

!TerniLapilli methodsFor: 'evaluate' stamp: 'A 11/5/2018 20:38:56'!
winner

	^winner.! !


!TerniLapilli methodsFor: 'accessing' stamp: 'mc 11/8/2018 01:49:09'!
at: aPoint 

	^board at: aPoint.! !


!TerniLapilli methodsFor: 'play' stamp: 'mc 11/8/2018 01:52:30'!
move: aChip from: fromPoint to: toPoint

	self validateTurnFor: aChip.
	state move: aChip from: fromPoint to: toPoint  on: self.! !

!TerniLapilli methodsFor: 'play' stamp: 'mc 11/8/2018 01:52:23'!
put: aChip at: aPoint 

	self validateTurnFor: aChip.
	state put: aChip  at: aPoint on: self. ! !


!TerniLapilli methodsFor: 'error' stamp: 'mc 11/8/2018 01:19:00'!
cantMoveToPositionAlreadyTakenErrorMessage

	^'No se puede mover a una posición ya ocupada.'! !

!TerniLapilli methodsFor: 'error' stamp: 'mc 11/8/2018 01:22:49'!
cantPutIntoAPositionAlreadyTakenErrorMessage

	^'No se puede poner una fucha en una posicion ya ocupada'.! !

!TerniLapilli methodsFor: 'error' stamp: 'mc 11/8/2018 01:23:40'!
gameOverNoMorePlaysErrorMessage

	^'El juego termino, no se permiten mas jugadas'.! !

!TerniLapilli methodsFor: 'error' stamp: 'mc 11/8/2018 01:45:25'!
notEnoughChipsToStartMoveErrorMessage

	^'No se tienen la cantidad de fichas necesarias para empezar a mover'.! !

!TerniLapilli methodsFor: 'error' stamp: 'mc 11/8/2018 01:14:10'!
notMoreChipsErrorMessage

	^'Los jugadores no pueden colocar mas fichas, ahora deben mover'.! !

!TerniLapilli methodsFor: 'error' stamp: 'A 11/5/2018 19:22:59'!
playerCantPlayTwiceInARowErrorMessage
	^'El jugador no puede jugar dos veces seguidas'.! !


!TerniLapilli methodsFor: 'private' stamp: 'mc 11/8/2018 02:17:11'!
controlDiagonalsFor: aChip

	^((board at: 1 @1 ) = aChip and: [(board at: 2 @2 ) = aChip and: [(board at: 3 @3 ) = aChip]]) 
		or:[(board at: 1 @3 ) = aChip and: [(board at: 2 @2 ) = aChip and: [(board at: 3 @1 ) = aChip]]].! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/8/2018 02:29:50'!
controlHorizontalLineFor: aChip on: i

	^(board at: i @1 ) = aChip and: [(board at: i @2 ) = aChip and: [(board at: i @3 ) = aChip]] .! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/8/2018 02:10:03'!
controlHorizontalLinesFor: aChip

	^(self controlHorizontalLineFor: aChip on:1) 
		or: [
			(self controlHorizontalLineFor: aChip on:2) 
				or:[self controlHorizontalLineFor: aChip on:3].
				].! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/7/2018 22:32:20'!
controlIfLastMoveWins

	(self hasWon: lastPlayer ) ifTrue: 
	[
		state _ TerniLapilliOverState new.
		winner := lastPlayer .
		]! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/8/2018 02:29:24'!
controlVerticalLineFor: aChip on: j

	^(board at: 1@j ) = aChip and: [(board at: 2@j ) = aChip and: [(board at: 3@j ) = aChip]] .! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/8/2018 02:09:39'!
controlVerticalLinesFor: aChip

	^(self controlVerticalLineFor: aChip on:1) 
		or: [
			(self controlVerticalLineFor: aChip on:2) 
				or:[self controlVerticalLineFor: aChip on:3].
				].! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/8/2018 01:19:00'!
validateMovefor: aChip from: fromPoint to: toPoint

	(board at: toPoint) ifNotNil: [self error: self cantMoveToPositionAlreadyTakenErrorMessage.].! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/8/2018 01:22:04'!
validatePutfor: aChip and: aPoint

		"Cant put in a occupied slot (?)"
		(board at: aPoint) ifNotNil: [self error: self cantPutIntoAPositionAlreadyTakenErrorMessage ].

! !

!TerniLapilli methodsFor: 'private' stamp: 'mc 11/8/2018 00:39:12'!
validateTurnFor: aChip

	lastPlayer = aChip ifTrue: [self error: self playerCantPlayTwiceInARowErrorMessage.]! !


!TerniLapilli methodsFor: 'initialize' stamp: 'mc 11/8/2018 01:29:55'!
initialize

	board _ Array2D height: 3 width:3. 
	chips := 0.
	state _ TerniLapilliStartState new.! !


!TerniLapilli methodsFor: 'safe move' stamp: 'mc 11/8/2018 02:36:53'!
safeMove: aChip  from: fromPoint to: toPoint
 
	board at: fromPoint put: nil.
	board at: toPoint put: aChip.
	lastPlayer := aChip.
	self controlIfLastMoveWins.! !

!TerniLapilli methodsFor: 'safe move' stamp: 'mc 11/8/2018 02:36:36'!
safePut: aChip  on: aPoint
 
	board at: aPoint put: aChip.
	lastPlayer := aChip.
	chips _ chips +1.
	" esto no se si deberia estar aca deberia manejarlo el state "
	chips = 6 ifTrue: [state _ TerniLapilliMovingState new].
	" esto seguro que lo deberia manejar el estado"
	self controlIfLastMoveWins.! !

!TerniLapilli methodsFor: 'safe move' stamp: 'mc 11/8/2018 02:32:44'!
setState: newState

	state _ newState.! !

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

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 01:11:00'!
move: aChip from: fromPoint to: toPoint on: aTerniLapilli 
	
	self subclassResponsibility .! !

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 01:11:18'!
put: aChip at: aPoint on: aTerniLapilli

	self subclassResponsibility.! !


!classDefinition: #TerniLapilliMovingState category: #'TerniLapilli-Ejercicio'!
TerniLapilliState subclass: #TerniLapilliMovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliMovingState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 02:37:34'!
move: aChip from: fromPoint to: toPoint on: aTerniLapilli 
	
	aTerniLapilli validateMovefor: aChip  from:  fromPoint to: toPoint.
	aTerniLapilli  safeMove: aChip from: fromPoint to: toPoint.! !

!TerniLapilliMovingState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 01:14:44'!
put: aChip at: aPoint on: aTerniLapilli

	self error: aTerniLapilli notMoreChipsErrorMessage! !


!classDefinition: #TerniLapilliOverState category: #'TerniLapilli-Ejercicio'!
TerniLapilliState subclass: #TerniLapilliOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliOverState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 00:46:25'!
isOver

	^true.! !

!TerniLapilliOverState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 01:23:27'!
move: aChip from: fromPoint to: toPoint on: aTerniLapilli 
	
	self error: aTerniLapilli gameOverNoMorePlaysErrorMessage! !

!TerniLapilliOverState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 01:23:27'!
put: aChip at: aPoint on: aTerniLapilli

	self error: aTerniLapilli gameOverNoMorePlaysErrorMessage! !


!classDefinition: #TerniLapilliStartState category: #'TerniLapilli-Ejercicio'!
TerniLapilliState subclass: #TerniLapilliStartState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliStartState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 00:47:16'!
isEmpty

	^true.! !

!TerniLapilliStartState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 01:36:17'!
move: aChip from: fromPoint to: toPoint on: aTerniLapilli 
	
	self error: aTerniLapilli notEnoughChipsToStartMoveErrorMessage.! !

!TerniLapilliStartState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 02:38:13'!
put: aChip at: aPoint on: aTerniLapilli

	
	aTerniLapilli safePut: aChip on: aPoint.
	aTerniLapilli setState: TerniLapilliVacantState  new.! !


!classDefinition: #TerniLapilliVacantState category: #'TerniLapilli-Ejercicio'!
TerniLapilliState subclass: #TerniLapilliVacantState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliVacantState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 01:36:39'!
move: aChip from: fromPoint to: toPoint on: aTerniLapilli 
	
	self error: aTerniLapilli notEnoughChipsToStartMoveErrorMessage.! !

!TerniLapilliVacantState methodsFor: 'as yet unclassified' stamp: 'mc 11/8/2018 02:36:07'!
put: aChip at: aPoint on: aTerniLapilli

	aTerniLapilli validatePutfor: aChip and: aPoint.
	aTerniLapilli safePut: aChip on: aPoint.! !
