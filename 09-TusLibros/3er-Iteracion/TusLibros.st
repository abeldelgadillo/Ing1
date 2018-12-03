!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: #TusLibros!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 17:37:50'!
test01CreateACartForInvalidClientOrPasswordShouldRaiseError

	| aRestInterface noExistenClient clientPassword existenClient catalog clientList |
	
	existenClient _ 1.
	noExistenClient _ 2.
	clientPassword _ '123'.
	
	clientList _ Dictionary new at: existenClient put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	aRestInterface  _ RestInterface with: clientList and: catalog.
	
	self should: [ aRestInterface createCartFor:noExistenClient withPassword: clientPassword] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = RestInterface invalidUserOrPassword].
		
	self should: [ aRestInterface createCartFor:'' withPassword: clientPassword] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = RestInterface invalidUserOrPassword].
		
	self should: [ aRestInterface createCartFor:existenClient withPassword: ''] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = RestInterface invalidUserOrPassword].! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 17:13:14'!
test02CreateACartForAValidClientAndPasswordShouldCreateAnEmptyCart

	| clientPassword restInterface cartId catalog clientList existenClient |
	
	existenClient _ 1.
	clientPassword _ '123'.
		clientList _ Dictionary new at: existenClient put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	cartId _  restInterface createCartFor:existenClient withPassword: clientPassword.
	
	self assert: OrderedCollection new equals: (restInterface list: cartId) .! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 17:39:45'!
test03AddToCartAnInexistentCartShouldThrowError

	| client clientPassword restInterface catalog clientList |
	
	client _ 1.
	clientPassword _ '123'.
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	self should: [ restInterface add:1 of:'INVALID BOOK' to: 666.] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = RestInterface invalidCartId ].! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 17:40:21'!
test04AddAnInvalidBookToCartShouldThrowError


	| client clientPassword restInterface cartId invalidBook catalog clientList |
	
	client _ 1.
	clientPassword _ '123'.
	invalidBook _ StoreTestObjectsFactory new itemNotSellByTheStore.
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.

	self should:[restInterface add: 1 of: invalidBook to: cartId ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = Cart  new invalidItemErrorMessage]
! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 17:41:53'!
test05AddAnInvalidQunatityOfBooksToCartShouldThrowError


	| client clientPassword restInterface validBook cartId catalog clientList |
	
	client _ 1.
	clientPassword _ '123'.
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.
	
	self should:[restInterface add: -1 of: validBook to: cartId ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = Cart  new invalidQuantityErrorMessage]
! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 17:42:16'!
test06AddValidBooksToACartShouldMakeThemAppearOnTheCartList

	"Agregar libros al carrito es correcto o se hace correctamente"

	| client clientPassword restInterface validBook cartId catalog clientList |
	
	client _ 1.
	clientPassword _ '123'.
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.

	self assert: 0 equals: (restInterface list: cartId) size.
	self assert: 0 equals: ( (restInterface list: cartId) occurrencesOf: validBook ).

	restInterface add: 2 of: validBook to: cartId.
	
	self assert: 2 equals: (restInterface list: cartId) size.
	self assert: 2 equals: ( (restInterface list: cartId) occurrencesOf: validBook ).
! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 17:42:35'!
test07ListAnInvalidCartShouldThrowInvalidCartIdError

	| client clientPassword restInterface catalog clientList |

	client _ 1.
	clientPassword _ '123'.
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.	
	
	self should: [restInterface list: 666]
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = RestInterface invalidCartId ].! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 17:43:07'!
test08ListACartDoesNotContainsNotAddedBooks

	| client clientPassword restInterface cartId invalidBook validBook catalog clientList |

	client _ 1.
	clientPassword _ '123'.
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	invalidBook _ StoreTestObjectsFactory new itemNotSellByTheStore.
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.	
	
	restInterface add: 2 of: validBook to: cartId.
	
	self assert: 0 equals: ( (restInterface list: cartId) occurrencesOf: invalidBook ).
	
	! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 17:43:29'!
test09CheckoutOfAnNonExistentCartShouldThrowError

	| client clientPassword restInterface validDate catalog clientList |

	client _ 1.
	clientPassword _ '123'.
	validDate _ (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1).
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.	
	
	self should: [restInterface checkout: 666 chargingTo: 4929060755662917 expiringOn: validDate
		withOwner: 'Willie Nelson'.] 
		raise:  Error
		withExceptionDo:[ :anError | self assert: anError messageText = RestInterface invalidCartId ].! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 18:26:33'!
test10CheckoutOfAnEmptyCartShouldThrowError

	| client clientPassword restInterface validDate catalog clientList cartId |

	client _ 1.
	clientPassword _ '123'.
	validDate _ (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1).
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.	
	
	self should: [restInterface checkout: cartId chargingTo: 4929060755662917 expiringOn: validDate
		withOwner: 'Willie Nelson'.] 
		raise:  Error
		withExceptionDo:[ :anError | self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage ].! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 20:51:35'!
test11CheckoutWithAnExpiredCreditCardShouldThrowError

	| client clientPassword restInterface catalog clientList cartId validBook expiredDate |

	client _ 1.
	clientPassword _ '123'.
	expiredDate _ (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber - 1).
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.	
	
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	restInterface add: 2 of: validBook to: cartId.
	
	self should: [restInterface checkout: cartId chargingTo: 4929060755662917 expiringOn: expiredDate
		withOwner: '1'.] 
		raise:  Error
		withExceptionDo:[ :anError | self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage ].! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 20:42:31'!
test12CheckoutWithInvalidOwnerForACreditCardShouldThrowError

	| client clientPassword restInterface catalog clientList cartId validBook validDate |

	client _ 1.
	clientPassword _ '123'.
	validDate _ (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1).
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.	
	
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	restInterface add: 2 of: validBook to: cartId.
	
	self should: [restInterface checkout: cartId chargingTo: 4929060755662917 expiringOn: validDate
		withOwner: ''.] 
		raise:  Error
		withExceptionDo:[ :anError | self assert: anError messageText = Cashier invalidCreditCardOwnerErrorMessage ].! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/2/2018 20:51:10'!
test13CheckoutWithInvalidNumberForACreditCardShouldThrowError

	| client clientPassword restInterface catalog clientList cartId validBook validDate |

	client _ 1.
	clientPassword _ '123'.
	validDate _ (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1).
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.	
	
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	restInterface add: 2 of: validBook to: cartId.
	
	self should: [restInterface checkout: cartId chargingTo: 123456789012345 expiringOn: validDate
		withOwner: '1'.] 
		raise:  Error
		withExceptionDo:[ :anError | self assert: anError messageText = Cashier invalidCreditCardNumberErrorMessage ].! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'mc 12/2/2018 17:38:34'!
listItems

	^ items copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'mc 12/2/2018 21:03:11'!
assertIsValidCreditCardNumber: aCreditCard
	
	| number |
	number  _ aCreditCard number.
	(number notNil and:[number asString size  = 16]) ifFalse: [ self error: self invalidCreditCardNumberErrorMessage ]
	
	! !

!Cashier class methodsFor: 'assertions' stamp: 'mc 12/2/2018 20:44:57'!
assertIsValidCreditCardOwner: aCreditCard
	
	(aCreditCard owner = '' or:[ aCreditCard owner=nil]) ifTrue: [ self error: self invalidCreditCardOwnerErrorMessage ]
	
	! !


!Cashier class methodsFor: 'instance creation' stamp: 'mc 12/2/2018 20:50:42'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	self assertIsValidCreditCardOwner: aCreditCard.
	self assertIsValidCreditCardNumber: aCreditCard.

	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !

!Cashier class methodsFor: 'error messages' stamp: 'mc 12/2/2018 20:44:02'!
invalidCreditCardNumberErrorMessage
	
	^'Invalid credit card number'! !

!Cashier class methodsFor: 'error messages' stamp: 'mc 12/2/2018 20:42:48'!
invalidCreditCardOwnerErrorMessage
	
	^'Invalid name for credit card owner'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

!CreditCard methodsFor: 'testing' stamp: 'mc 12/2/2018 20:55:03'!
number 

	^number.! !

!CreditCard methodsFor: 'testing' stamp: 'mc 12/2/2018 20:36:48'!
owner 
	
	^owner.! !


!CreditCard methodsFor: 'initialization' stamp: 'mc 12/2/2018 21:05:52'!
initializeExpiringOn: aMonth for: aName with: aNumber
	
	expiration := aMonth .
	owner _ aName .
	number _ aNumber .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'mc 12/2/2018 21:06:31'!
expiringOn: aMonth for: aName with: aNumber
	
	^self new initializeExpiringOn: aMonth for: aName  with: aNumber.! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'clients openCarts lastId catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'mc 12/2/2018 17:08:04'!
initializeWith: aClientList and: aCatalog
	
	clients _ aClientList.
	catalog _ aCatalog .
	
	openCarts _ Dictionary new.
	
	
	lastId _ 0.! !


!RestInterface methodsFor: 'accessing' stamp: 'mc 11/25/2018 21:18:34'!
cartFor: aClientId
	
	^ (openCarts at: aClientId) copy.! !


!RestInterface methodsFor: 'public protocol' stamp: 'mc 12/2/2018 12:13:06'!
add: aQuantity of: aBook to: aCartId

	self assertValidCartId: aCartId.
	(openCarts at: aCartId) add: aQuantity of: aBook.! !

!RestInterface methodsFor: 'public protocol' stamp: 'mc 12/2/2018 21:16:27'!
checkout: aCartId chargingTo: aCreditCardNumber expiringOn: aDate withOwner: aName

	| cart  creditCard aMerchantProcessor aSalesBook |
	
	self assertValidCartId: aCartId .
	
	cart _ openCarts at: aCartId .
	creditCard _ CreditCard expiringOn: aDate for: aName with: aCreditCardNumber.
	
	"explicit set to nil to later set correctly"
	aMerchantProcessor _ nil.
	aSalesBook _ nil.
	
	^ Cashier toCheckout: cart charging: creditCard throught: aMerchantProcessor on: (DateAndTime now) registeringOn: aSalesBook.! !

!RestInterface methodsFor: 'public protocol' stamp: 'mc 11/28/2018 00:49:21'!
createCartFor: aClient withPassword: aPassword

	"validate user and password "
	| savedPassword |	
	savedPassword  _ clients at: aClient ifAbsent: [^ self error: self class invalidUserOrPassword. ].
	savedPassword  = aPassword  ifFalse: [^ self error: self class invalidUserOrPassword. ].
		
	lastId _ lastId  + 1.
	
	openCarts at: lastId put: StoreTestObjectsFactory  new createCart.
	
	^ lastId.! !

!RestInterface methodsFor: 'public protocol' stamp: 'mc 12/2/2018 17:39:04'!
list: aCartId
 
	self assertValidCartId: aCartId .
	^(openCarts at: aCartId) listItems.! !


!RestInterface methodsFor: 'private' stamp: 'mc 12/2/2018 18:32:36'!
assertValidCartId: aCartId
 
	 openCarts at: aCartId  ifAbsent: [self error: self class invalidCartId].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'error message' stamp: 'mc 12/2/2018 11:45:47'!
invalidCartId

	  ^'El ID de carrito no es valido'.! !

!RestInterface class methodsFor: 'error message' stamp: 'mc 11/25/2018 20:20:39'!
invalidUserOrPassword

	  ^'Usuario o Password invalido'.! !


!RestInterface class methodsFor: 'instance creation' stamp: 'mc 11/25/2018 20:47:31'!
with: aDictionary
	
	^ self new initializeWith: aDictionary .! !

!RestInterface class methodsFor: 'instance creation' stamp: 'mc 12/2/2018 17:10:35'!
with: aClientList and: aCatalog
	
	^ self new initializeWith: aClientList and: aCatalog .! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'mc 12/2/2018 21:17:06'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) for: 'Client' with:1234567890123456! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'mc 12/2/2018 21:14:43'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) for:'Client' with:1234567890123456.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
