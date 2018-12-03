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
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 05:50:21'!
test01CreateACartForInvalidClientOrPasswordShouldRaiseError

	| restInterface noExistenClient clientPassword existenClient catalog clientList |
	
	existenClient _ 1.
	noExistenClient _ 2.
	clientPassword _ '123'.
	
	clientList _ Dictionary new at: existenClient put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	self should: [ restInterface createCartFor:noExistenClient withPassword: clientPassword] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = restInterface invalidUserOrPassword].
		
	self should: [ restInterface createCartFor:'' withPassword: clientPassword] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = restInterface invalidUserOrPassword].
		
	self should: [ restInterface createCartFor:existenClient withPassword: ''] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = restInterface invalidUserOrPassword].! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 05:58:05'!
test02CreateACartForAValidClientAndPasswordShouldCreateAnEmptyCart

	| clientPassword restInterface cartId catalog clientList existenClient |
	
	existenClient _ 1.
	clientPassword _ '123'.
		clientList _ Dictionary new at: existenClient put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	cartId _  restInterface createCartFor:existenClient withPassword: clientPassword.
	
	self assert: OrderedCollection new equals: (restInterface listCart: cartId) .! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 05:49:19'!
test03AddToCartAnInexistentCartShouldThrowError

	| client clientPassword restInterface catalog clientList |
	
	client _ 1.
	clientPassword _ '123'.
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.
	
	self should: [ restInterface add:1 of:'INVALID BOOK' to: 666.] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = restInterface invalidCartId ].! !

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

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 05:58:05'!
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

	self assert: 0 equals: (restInterface listCart: cartId) size.
	self assert: 0 equals: ( (restInterface listCart: cartId) occurrencesOf: validBook ).

	restInterface add: 2 of: validBook to: cartId.
	
	self assert: 2 equals: (restInterface listCart: cartId) size.
	self assert: 2 equals: ( (restInterface listCart: cartId) occurrencesOf: validBook ).
! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 05:58:05'!
test07ListAnInvalidCartShouldThrowInvalidCartIdError

	| client clientPassword restInterface catalog clientList |

	client _ 1.
	clientPassword _ '123'.
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.	
	
	self should: [restInterface listCart: 666]
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = restInterface invalidCartId ].! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 05:58:05'!
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
	
	self assert: 0 equals: ( (restInterface listCart: cartId) occurrencesOf: invalidBook ).
	
	! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 05:49:01'!
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
		withExceptionDo:[ :anError | self assert: anError messageText = restInterface invalidCartId ].! !

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

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 06:18:40'!
test14CheckoutTotalIsCorrect

	| client clientPassword restInterface catalog clientList cartId validBook validDate total otherValidBook |

	client _ 1.
	clientPassword _ '123'.
	validDate _ (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1).
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog using: self.
	
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.	
	
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	otherValidBook _ StoreTestObjectsFactory new otherItemSellByTheStore.
	
	restInterface add: 2 of: validBook to: cartId.
	restInterface add: 1 of: otherValidBook to: cartId.

	debitBehavior _ [:value :creditCard |].
	total _ restInterface checkout: cartId chargingTo: 1234567890123456 expiringOn: validDate withOwner: '1'.
	
	self assert: total  equals: StoreTestObjectsFactory new itemSellByTheStorePrice * 2 +StoreTestObjectsFactory new otherItemSellByTheStorePrice.! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 06:24:50'!
test15CheckoutRegisterTheSale

	| client clientPassword restInterface catalog clientList cartId validBook validDate total otherValidBook purchases |

	client _ 1.
	clientPassword _ '123'.
	validDate _ (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1).
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog using: self.
	
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.	
	
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	otherValidBook _ StoreTestObjectsFactory new otherItemSellByTheStore.
	
	restInterface add: 2 of: validBook to: cartId.
	restInterface add: 1 of: otherValidBook to: cartId.
	
	debitBehavior _ [:value :creditCard |].
	total _ restInterface checkout: cartId chargingTo: 1234567890123456 expiringOn: validDate withOwner: '1'.
	
	purchases _ restInterface listPurchasesFor:client with:clientPassword .
"	self assert: total  equals: StoreTestObjectsFactory new itemSellByTheStorePrice * 3."
	self assert:  purchases size equals: 1.
	self assert:  (purchases at:1) total equals: total.
	! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 07:25:30'!
test16ListPurchaseOfNonValidClientShouldThrowError

	| restInterface catalog clientList existenClient existentClientPassword noExistenClient |

	existenClient _ 1.
	noExistenClient _ 2.
	existentClientPassword _ '123'.
	clientList _ Dictionary new at: existenClient put:existentClientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog using: self.
	
	
	self should: [ restInterface listPurchasesFor:noExistenClient with: existentClientPassword] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = restInterface invalidUserOrPassword].
		
	self should: [ restInterface listPurchasesFor:'' with: existentClientPassword] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = restInterface invalidUserOrPassword].
		
	self should: [ restInterface listPurchasesFor:existenClient with: ''] 
		raise: Error
		withExceptionDo:[ :anError | self assert: anError messageText = restInterface invalidUserOrPassword].! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 07:29:57'!
test17ListPurchaseForAClientWithNoPurchaseShouldBeEmpty

	| restInterface catalog clientList existenClient existentClientPassword purchaseList |

	existenClient _ 1.
	existentClientPassword _ '123'.
	clientList _ Dictionary new at: existenClient put:existentClientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog using: self.

	purchaseList _ restInterface listPurchasesFor:existenClient with: existentClientPassword. 
	self assert: purchaseList isEmpty.
	
	! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 08:12:44'!
test18ListPurchaseForAClientShouldHaveTheTotalOfPurchasesOfTheClient

	| client clientPassword restInterface catalog clientList cartId validBook validDate total otherValidBook purchases purchaseTotal |

	client _ 1.
	clientPassword _ '123'.
	validDate _ (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1).
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog using: self.	
	
	debitBehavior _ [:value :creditCard |].
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	otherValidBook _ StoreTestObjectsFactory new otherItemSellByTheStore.
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.
	restInterface add: 1 of: validBook to: cartId.
	total _ restInterface checkout: cartId chargingTo: 1234567890123456 expiringOn: validDate withOwner: '1'.
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.
	restInterface add: 1 of: otherValidBook to: cartId.
	total _ total +  (restInterface checkout: cartId chargingTo: 1234567890123456 expiringOn: validDate withOwner: '1').
	
	purchases _ restInterface listPurchasesFor:client with:clientPassword .
	
	self assert: purchases size equals: 2.
	purchaseTotal _ purchases sum: [ :aPurchase | aPurchase total].
	self assert: (purchaseTotal ) equals: total.
	
! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 09:03:10'!
test19ListPurchaseForAClientShouldContainTheListOfPurchasedItems

	| client clientPassword restInterface catalog clientList cartId validBook validDate total otherValidBook purchases purchasedItems |

	client _ 1.
	clientPassword _ '123'.
	validDate _ (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1).
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog using: self.	
	
	debitBehavior _ [:value :creditCard |].
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	otherValidBook _ StoreTestObjectsFactory new otherItemSellByTheStore.
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.
	restInterface add: 1 of: validBook to: cartId.
	total _ restInterface checkout: cartId chargingTo: 1234567890123456 expiringOn: validDate withOwner: '1'.
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.
	restInterface add: 1 of: otherValidBook to: cartId.
	total _ total +  (restInterface checkout: cartId chargingTo: 1234567890123456 expiringOn: validDate withOwner: '1').
	
	purchases _ restInterface listPurchasesFor:client with:clientPassword .
	
	self assert: purchases size equals: 2.
	purchasedItems _ OrderedCollection new.
	purchases do: [ :aPurchase | purchasedItems addAll: aPurchase itemList].
	self assert: (purchasedItems occurrencesOf: validBook ) equals: 1.
	self assert: (purchasedItems occurrencesOf: otherValidBook ) equals: 1.! !

!RestInterfaceTest methodsFor: 'test' stamp: 'mc 12/3/2018 17:06:32'!
test20CantAddToBookAnExpiredCart

	| client clientPassword restInterface validBook cartId catalog clientList aClock |
	
	client _ 1.
	clientPassword _ '123'.
	validBook _ StoreTestObjectsFactory new itemSellByTheStore.
	clientList _ Dictionary new at: client put:clientPassword; yourself.
	catalog _ StoreTestObjectsFactory new defaultCatalog.
	restInterface  _ RestInterface with: clientList and: catalog.	
	aClock _ ServerClock now.
	restInterface  _ RestInterface with: clientList and: catalog using: self timingWith: aClock.
	
	cartId _ restInterface createCartFor:client withPassword: clientPassword.
	
	self assert: 0 equals: (restInterface listCart: cartId) size.
	self assert: 0 equals: ( (restInterface listCart: cartId) occurrencesOf: validBook ).

	restInterface add: 2 of: validBook to: cartId.
	
	self assert: 2 equals: (restInterface listCart: cartId) size.
	self assert: 2 equals: ( (restInterface listCart: cartId) occurrencesOf: validBook ).
! !


!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'mc 12/2/2018 23:53:38'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'mc 12/3/2018 08:58:16'!
createSale

	^ Sale of: total with: cart listItems .
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
	instanceVariableNames: 'clients openCarts lastId catalog merchantProcessor salesBook cartOwner salesByClient serverClock cartSession'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'mc 12/3/2018 07:05:16'!
initializeWith: aClientList and: aCatalog
	
	self initializeWith: aClientList and: aCatalog chargingThrought: nil .! !

!RestInterface methodsFor: 'initialization' stamp: 'mc 12/3/2018 15:33:02'!
initializeWith: aClientList and: aCatalog chargingThrought: aMerchantProcessor .
	
	
	clients _ aClientList.
	catalog _ aCatalog .
	
	openCarts _ Dictionary new.
	merchantProcessor _ aMerchantProcessor .
	salesBook _ OrderedCollection new.	
	cartOwner _ Dictionary new.	
	salesByClient _ Dictionary new.
	lastId _ 0.
	
	serverClock _ ServerClock now.! !

!RestInterface methodsFor: 'initialization' stamp: 'mc 12/3/2018 17:10:57'!
initializeWith: aClientList and: aCatalog chargingThrought: aMerchantProcessor startingAt: aServerClock.
	
	
	clients _ aClientList.
	catalog _ aCatalog .
	
	openCarts _ Dictionary new.
	merchantProcessor _ aMerchantProcessor .
	salesBook _ OrderedCollection new.	
	cartOwner _ Dictionary new.	
	salesByClient _ Dictionary new.
	cartSession _ Dictionary new.
	
	lastId _ 0.
	
	serverClock _ aServerClock .! !


!RestInterface methodsFor: 'public protocol' stamp: 'mc 12/3/2018 16:25:16'!
add: aQuantity of: aBook to: aCartId

	
	self assertValidCartId: aCartId.
	self assertNotExpiredSession: aCartId.
	(openCarts at: aCartId) add: aQuantity of: aBook.! !

!RestInterface methodsFor: 'public protocol' stamp: 'mc 12/3/2018 16:59:00'!
checkout: aCartId chargingTo: aCreditCardNumber expiringOn: aDate withOwner: aName

	| cart  creditCard cashier saleTotal clientId salesList |
	
	self assertValidCartId: aCartId .
		self assertNotExpiredSession: aCartId.
	
	cart _ openCarts at: aCartId .
	creditCard _ CreditCard expiringOn: aDate for: aName with: aCreditCardNumber.

	cashier _  Cashier toCheckout: cart charging: creditCard throught: merchantProcessor on: (DateAndTime now) registeringOn: salesBook.
	saleTotal _ cashier checkOut.
	
	"tengo que tomar el dueño del carrito y registrarle la compra"
	clientId _ cartOwner at: aCartId. 
	
	salesList _ salesByClient at: clientId ifAbsent: [salesByClient at: clientId put:OrderedCollection new].
	salesList add: (salesBook at: salesBook size).
		
	^ saleTotal.! !

!RestInterface methodsFor: 'public protocol' stamp: 'mc 12/3/2018 16:14:07'!
createCartFor: aClientId withPassword: aPassword

	"validate user and password "
	"
	| savedPassword |	
	savedPassword  _ clients at: aClientId ifAbsent: [^ self error: self invalidUserOrPassword. ].
	savedPassword  = aPassword  ifFalse: [^ self error: self invalidUserOrPassword. ].
	"
	self assertValidUser:aClientId  andPassword:aPassword .
	lastId _ lastId  + 1.
	
	cartOwner at: lastId put: aClientId .
	openCarts at: lastId put: (Cart acceptingItemsOf: catalog) .
	cartSession at: lastId put: DateAndTime now. 
	
	^ lastId.! !

!RestInterface methodsFor: 'public protocol' stamp: 'mc 12/3/2018 16:59:44'!
listCart: aCartId
 
	self assertValidCartId: aCartId .
	self assertNotExpiredSession: aCartId.
	^(openCarts at: aCartId) listItems.! !

!RestInterface methodsFor: 'public protocol' stamp: 'mc 12/3/2018 07:24:13'!
listPurchasesFor: aClientId with: aPassword
	
	self assertValidUser: aClientId andPassword: aPassword.
	^salesBook! !


!RestInterface methodsFor: 'error messages' stamp: 'mc 12/3/2018 05:46:57'!
invalidCartId

	  ^'El ID de carrito no es valido'.! !

!RestInterface methodsFor: 'error messages' stamp: 'mc 12/3/2018 05:47:02'!
invalidUserOrPassword

	  ^'Usuario o Password invalido'.! !


!RestInterface methodsFor: 'private' stamp: 'mc 12/3/2018 16:56:04'!
assertNotExpiredSession: aCartId
 
	 | lastUpdatedTime currentTime passTime | 
	  
	lastUpdatedTime _ cartSession at: aCartId .
	
	currentTime _ serverClock time.
	
	passTime  _ (currentTime  - lastUpdatedTime ). 

	passTime > 0 minutes and:[passTime < 30 minutes].! !

!RestInterface methodsFor: 'private' stamp: 'mc 12/3/2018 05:47:58'!
assertValidCartId: aCartId
 
	 openCarts at: aCartId  ifAbsent: [self error: self invalidCartId].! !

!RestInterface methodsFor: 'private' stamp: 'mc 12/3/2018 07:25:02'!
assertValidUser: aClientId andPassword: aPassword
 
	| savedPassword |	
	savedPassword  _ clients at: aClientId ifAbsent: [^ self error: self invalidUserOrPassword. ].
	savedPassword  = aPassword  ifFalse: [^ self error: self invalidUserOrPassword. ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'mc 12/2/2018 17:10:35'!
with: aClientList and: aCatalog
	
	^ self new initializeWith: aClientList and: aCatalog .! !

!RestInterface class methodsFor: 'instance creation' stamp: 'mc 12/3/2018 01:09:13'!
with: aClientList and: aCatalog using: aMerchantProcessor 
	
	^ self new initializeWith: aClientList and: aCatalog chargingThrought: aMerchantProcessor .! !

!RestInterface class methodsFor: 'instance creation' stamp: 'mc 12/3/2018 17:04:20'!
with: aClientList and: aCatalog using: aMerchantProcessor timingWith: aServerClock
	
	^ self new initializeWith: aClientList and: aCatalog chargingThrought: aMerchantProcessor startingAt: aServerClock.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'mc 12/3/2018 09:00:56'!
itemList
	
	^ items copy.! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'mc 12/3/2018 09:00:23'!
initializeTotal: aTotal

	self initializeTotal: aTotal and:OrderedCollection new.! !

!Sale methodsFor: 'initialization' stamp: 'mc 12/3/2018 08:59:56'!
initializeTotal: aTotal and:aItemList.

	total := aTotal.
	items _ aItemList .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !

!Sale class methodsFor: 'instance creation' stamp: 'mc 12/3/2018 08:59:33'!
of: aTotal with: aItemList

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal  and:aItemList.! !


!classDefinition: #ServerClock category: #TusLibros!
Object subclass: #ServerClock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ServerClock methodsFor: 'initialization' stamp: 'mc 12/3/2018 15:49:41'!
advance: aDuration

	"assert que me estan mandando una duration"
	time _ time + aDuration .! !

!ServerClock methodsFor: 'initialization' stamp: 'mc 12/3/2018 15:35:44'!
initializeAt: aDateAndTime 
	
	time _ aDateAndTime .! !

!ServerClock methodsFor: 'initialization' stamp: 'mc 12/3/2018 16:02:04'!
regress: aDuration

	"assert que me estan mandando una duration"
	time _ time - aDuration .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ServerClock class' category: #TusLibros!
ServerClock class
	instanceVariableNames: ''!

!ServerClock class methodsFor: 'instance creation' stamp: 'mc 12/3/2018 15:32:10'!
now

	" talvez se deba agregar una validacion de que lo que se pase sea una fecha... "
	^self startingAt: DateAndTime now.! !

!ServerClock class methodsFor: 'instance creation' stamp: 'mc 12/3/2018 15:30:18'!
startingAt: aDate

	" talvez se deba agregar una validacion de que lo que se pase sea una fecha... "
	^self new initializeAt: aDate.! !


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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'mc 12/3/2018 06:13:59'!
otherItemSellByTheStore
	
	^ 'otherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'mc 12/3/2018 06:06:13'!
otherItemSellByTheStorePrice
	
	^15! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'mc 12/3/2018 06:18:04'!
defaultCatalog
	
	| catalog |
	catalog _  Dictionary new.
	catalog at: self itemSellByTheStore put: self itemSellByTheStorePrice.
	catalog at: self otherItemSellByTheStore put: self otherItemSellByTheStorePrice.
	^ catalog.! !


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
