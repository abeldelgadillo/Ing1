!classDefinition: #CarritoTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #CarritoTest
	instanceVariableNames: 'validBook otherValidBook cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CarritoTest methodsFor: 'testing' stamp: 'mc 11/14/2018 01:58:30'!
test01ACartSohuldAddAValidBook

	"Agrega un item a un carrito vacio, lo deja con un item que es el que agregue"
	
	| newCart |
	
	newCart := Cart with: (OrderedCollection with:'un libro valido').
	
	newCart add: 'un libro valido'.
	
	self assert: 1 equals: newCart itemsQuantity.
	self assert: 1 equals: (newCart quantityOf: 'un libro valido').! !

!CarritoTest methodsFor: 'testing' stamp: 'mc 11/14/2018 01:52:58'!
test02AddAnInvalidBookToACartShouldThrowError

	"Intentar agregar un item no valido al carrito tira error"
	
	|newCart|
	
	newCart := Cart with: (OrderedCollection with:'un libro valido').
	
	
	
	self should:[newCart add: 'un libro no valido'.] raise:Error .! !

!CarritoTest methodsFor: 'testing' stamp: 'mc 11/13/2018 22:30:40'!
test03ACartShouldLetAddDifferentBooks

	"Agrega dos item distintos debe tener una cantidad uno de cada uno"
	
	cart add: validBook.
	cart add: otherValidBook.
	
	self assert: 2 equals: cart itemsQuantity.
	self assert: 1 equals: (cart quantityOf: validBook).
	self assert: 1 equals: (cart quantityOf: otherValidBook).! !

!CarritoTest methodsFor: 'testing' stamp: 'mc 11/14/2018 00:28:27'!
test04ACartShouldLetAddBooksInBatch

	"puedo agregar multiples copias de un libro"

	
	cart add:otherValidBook .
	cart add: validBook with: 2.
	
	self assert: 3 equals: cart itemsQuantity.
	self assert: 2 equals: (cart quantityOf: validBook).
	self assert: 1 equals: (cart quantityOf: otherValidBook).! !

!CarritoTest methodsFor: 'testing' stamp: 'mc 11/14/2018 01:13:35'!
test05TheQuantityOfBooksToAddShouldBeAnIntegerBiggerThanZero

	"Agregar en cantidad tiene que ser mayor a cero"
	
	self should:[cart add: validBook with: 0] raise:Error .
	self should:[cart add: validBook with: -1] raise:Error .
	self should:[cart add: validBook with: 1.25] raise:Error .! !

!CarritoTest methodsFor: 'testing' stamp: 'mc 11/14/2018 02:00:03'!
test06ACartShouldListTheProducts

	"para hacer esto de manera mas rapida puede que necesitemos usar un diccionario para el carrito"
	"
	| books |
	
	books _ cart list.
	
	self assert: books = ('un libro valido|1|otro libro valido|1').
	"! !


!CarritoTest methodsFor: 'setUp' stamp: 'mc 11/13/2018 22:25:21'!
setUp
		
		
	validBook := 'un libro valido'.
	otherValidBook := 'otro libro valido'.
	
	cart := Cart with:(OrderedCollection with:validBook with:otherValidBook ).! !


!classDefinition: #Cart category: #'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'evaluate' stamp: 'A 11/12/2018 20:13:41'!
itemsQuantity
	^items size.! !

!Cart methodsFor: 'evaluate' stamp: 'A 11/12/2018 20:37:21'!
quantityOf: aBook

	^items count:[:item | item = aBook ].! !


!Cart methodsFor: 'initialization' stamp: 'A 11/12/2018 20:09:19'!
initialize

	items := OrderedCollection new.! !


!Cart methodsFor: 'private validate' stamp: 'A 11/12/2018 21:38:21'!
validateAvailable: aBook

	(catalog includes: aBook) ifFalse:[self error: 'Ese libro no lo tengo CApo!!!!'].
	! !


!Cart methodsFor: 'add' stamp: 'A 11/12/2018 21:03:38'!
add: aItem 
	
	self validateAvailable: aItem.
	items add: aItem.! !


!Cart methodsFor: 'instantiation' stamp: 'A 11/12/2018 21:37:51'!
initializeWith: aCatalog 
	catalog  _ aCatalog.! !


!Cart methodsFor: 'accessing' stamp: 'mc 11/14/2018 00:27:59'!
add: aBook with: aQuantity 

	(aQuantity > 0 and:[ aQuantity isInteger]) ifFalse:[self error:'Cantidad no valida']. 	
	items add:  aBook  withOccurrences:  aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'A 11/12/2018 21:37:04'!
with: aCatalog 
	^self new initializeWith: aCatalog .! !
