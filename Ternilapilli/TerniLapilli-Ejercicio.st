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


!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board emptyBoard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'evaluate' stamp: 'mc 11/5/2018 14:15:27'!
isEmpty
	^emptyBoard .! !


!TerniLapilli methodsFor: 'accessing' stamp: 'mc 11/5/2018 14:15:01'!
initialize

	board _ Array2D height: 3 width:3. 
	emptyBoard _ true.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'mc 11/5/2018 14:15:18'!
put: aChip at: aPoint 

	board at: aPoint put: aChip.
	emptyBoard _ false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'instance creation' stamp: 'mc 11/5/2018 14:03:38'!
newGame
	
	^self new initialize.! !
