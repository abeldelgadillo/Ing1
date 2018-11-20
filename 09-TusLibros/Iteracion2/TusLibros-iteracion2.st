!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp' stamp: 'A 11/20/2018 15:50:33'!
catalog

	|priceList|

	priceList := Dictionary new.
	priceList add: ('libro valido' -> 10).	
	priceList add: ('otro libro valido' -> 5).
	^priceList.! !

!CashierTest methodsFor: 'setUp' stamp: 'A 11/20/2018 15:50:49'!
createCart

	^Cart acceptingItemsOf: self catalog.
! !

!CashierTest methodsFor: 'setUp' stamp: 'A 11/20/2018 16:27:36'!
expiredCreditCard

	^'tarjeta de credito vencida'! !

!CashierTest methodsFor: 'setUp' stamp: 'A 11/20/2018 16:27:48'!
notExpiredCreditCard

	^'tarjeta de credito'! !

!CashierTest methodsFor: 'setUp' stamp: 'A 11/15/2018 19:11:09'!
priceList

	|priceList|

	priceList := Dictionary new.
	priceList add: ('libro valido' -> 10).	
	priceList add: ('otro libro valido' -> 5).
	^priceList.! !


!CashierTest methodsFor: 'test' stamp: 'A 11/20/2018 16:28:13'!
test01TryToCheckoutAnEmptyCartShouldThrowAnError

	"Checkoutear un carrtio vacío tira error"

	|cashier cart|
	
	cashier := Cashier new.
	
	cart := self createCart.

	self 
		should:[cashier checkout: cart chargingTo: self notExpiredCreditCard]
		raise: Error
		withExceptionDo: [:error|
			self assert: error messageText = 'carrito vacio'.
			].

	self assert: 0 equals: cashier sales.! !

!CashierTest methodsFor: 'test' stamp: 'A 11/20/2018 16:30:54'!
test02CheckOutOfACartWithOnlyABookShouldReturnTheValueOfTheBook

	"Checkoutear un carrtio con un solo item"

	|cashier cart|
	
	cashier := Cashier new.
	
	cart := self createCart.
	cart add: 'libro valido'.

	self assert: (cashier checkout: cart chargingTo: self notExpiredCreditCard) equals: 10.
	self assert: cashier sales equals: 1.! !

!CashierTest methodsFor: 'test' stamp: 'A 11/20/2018 16:31:05'!
test03aCheckoutOfACartWithMultipleBooksShouldReturnTheSumOfValues

	"Checkoutear un carrtio con muchos items"

	|cashier cart|
	
	cashier := Cashier new.
	
	cart := self createCart.
	cart add: 2 of: 'libro valido'.

	self assert: (cashier checkout: cart chargingTo: self notExpiredCreditCard) equals: 20.! !

!CashierTest methodsFor: 'test' stamp: 'A 11/20/2018 16:31:18'!
test03bCheckoutOfACartWithDifferentBooksShouldReturnTheSumOfValues

	"Checkoutear un carrtio con muchos items distintos"

	|cashier cart |
	
	
	cashier := Cashier new.
	
	cart := self createCart.
	cart add: 2 of: 'libro valido'.
	cart add: 1 of: 'otro libro valido'.

	self assert: (cashier checkout: cart chargingTo: self notExpiredCreditCard) equals: 25.! !

!CashierTest methodsFor: 'test' stamp: 'A 11/20/2018 16:28:05'!
test04cantCheckoutWithExpiredCreditCard

	|cashier cart creditCard|
	
	creditCard := self expiredCreditCard.
	cashier := Cashier new.
	
	cart := self createCart.
	cart add: 2 of: 'libro valido'.
	cart add: 1 of: 'otro libro valido'.

	self 
		should:[cashier checkout: cart chargingTo: creditCard]
		raise: Error
		withExceptionDo: [:error|
			self assert: error messageText = 'tarjeta vencida'.
			].

	self assert: cashier sales equals: 0.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'A 11/20/2018 15:52:44'!
assertIsValidItem: anItem

	(catalog keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'A 11/20/2018 15:55:09'!
sumarize
	
	^items inject: 0 into: [:sum :item| sum + (catalog at: item)].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'A 11/20/2018 16:25:46'!
checkout: aCart 
	self isNotEmpty: aCart.
	sales := sales +1.
	^aCart sumarize.
	
	"^(aCart listOfItems) inject: 0 into: [:sum :item | sum + (self priceOf: item)]."! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'A 11/20/2018 16:30:20'!
checkout: aCart chargingTo: aCreditCard 

	aCreditCard = 'tarjeta de credito vencida' ifTrue: [self error: 'tarjeta vencida'].
	self isNotEmpty: aCart.

	sales := sales +1.
	^aCart sumarize.
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'A 11/20/2018 15:58:52'!
initialize

	sales := 0.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'A 11/20/2018 16:26:19'!
isNotEmpty: aCart

	^aCart isEmpty ifTrue: [self error: 'carrito vacio'].
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'A 11/15/2018 18:57:17'!
priceOf: aBook

	^priceList at: aBook.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'A 11/15/2018 20:30:28'!
sales
	^sales.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'A 11/15/2018 19:08:40'!
withPriceList: aPriceList 
	
	^self new initializeWith: aPriceList .! !
