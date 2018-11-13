!classDefinition: #CarritoTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #CarritoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CarritoTest methodsFor: 'test' stamp: 'A 11/12/2018 21:39:08'!
test01

	"Agrega un item a un carrito vacio, lo deja con un item que es el que agregue"
	
	|cart|
	
	cart := Cart with: (OrderedCollection with:'un libro valido').
	
	cart add: 'un libro valido'.
	
	self assert: 1 equals: cart itemsQuantity.
	self assert: 1 equals: (cart quantityOf: 'un libro valido').! !

!CarritoTest methodsFor: 'test' stamp: 'A 11/12/2018 21:40:13'!
test02

	"Intentar agregar un item no valido al carrito tira error"
	
	|cart|
	
	cart := Cart with: (OrderedCollection with:'un libro valido').
	
	
	
	self should:[cart add: 'un libro no valido'.] raise:Error .! !

!CarritoTest methodsFor: 'test' stamp: 'A 11/12/2018 21:26:49'!
test03

	"Intentar agregar un item no valido al carrito tira error"
	
	|cart|
	
	cart := Cart new.
	
	
	
	self should:[cart add: 'un libro no valido'.] raise:Error .
! !

!CarritoTest methodsFor: 'test' stamp: 'A 11/12/2018 20:38:16'!
test04

	"Agrega item a un carrito vacio, cantidad del item debe ser uno"
	
	|cart book|
	
	cart := Cart new.
	book := 'un libro'.
	
	cart add: book.
	
	self assert: 1 equals: (cart quantityOf: book).! !

!CarritoTest methodsFor: 'test' stamp: 'A 11/12/2018 20:38:46'!
test05

	"Agrega item dos veces a un carrito vacio, cantidad del item debe ser dos"
	
	|cart book|
	
	cart := Cart new.
	book := 'un libro'.
	
	cart add: book.
	cart add: book.
	
	self assert: 2 equals: (cart quantityOf: book).! !

!CarritoTest methodsFor: 'test' stamp: 'A 11/12/2018 20:33:18'!
test06

	"Agrega dos item distintos debe tener una cantidad uno de cada uno"
	
	|cart book otherBook|
	
	cart := Cart new.
	book := 'un libro'.
	otherBook := 'otro libro'.
	
	cart add: book.
	cart add: otherBook.
	
	self assert: 1 equals: (cart quantityOf: book).
	self assert: 1 equals: (cart quantityOf: otherBook).! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'A 11/12/2018 21:37:04'!
with: aCatalog 
	^self new initializeWith: aCatalog .! !
