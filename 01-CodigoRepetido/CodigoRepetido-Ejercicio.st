!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/23/2018 15:14:53'!
setUp

	customerBook := CustomerBook new.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/23/2018 15:16:39'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	self
		should: [ customerBook addCustomerNamed: 'John Lennon' ]
		takeLessThan: 50 * millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/23/2018 15:16:13'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| paulMcCartney |
	paulMcCartney _ 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	self
		should: [ customerBook removeCustomerNamed: paulMcCartney ]
		takeLessThan: 100 * millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/23/2018 15:16:17'!
test03CanNotAddACustomerWithEmptyName
	self
		shouldFail: [ customerBook addCustomerNamed: '' ]
		withErrorType: Error
		ifSoDo: [ :anError |
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/23/2018 15:16:21'!
test04CanNotRemoveAnInvalidCustomer
	| johnLennon |
	johnLennon _ 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self
		shouldFail: [ customerBook removeCustomerNamed: 'Paul McCartney' ]
		withErrorType: NotFound
		ifSoDo: [ :anError |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/23/2018 15:16:25'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| paulMcCartney |
	paulMcCartney _ 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	self
		shouldCustomer: paulMcCartney
		notBeRemovedFromCustomerBook: customerBook.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/23/2018 15:16:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| paulMcCartney |
	paulMcCartney _ 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	self
		shouldCustomer: paulMcCartney 
		beRemovedFromCustomerBook: customerBook .! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/23/2018 15:16:32'!
test07CanNotSuspendAnInvalidCustomer
	| johnLennon |
	johnLennon _ 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self
		shouldFail: [ customerBook suspendCustomerNamed: 'Paul McCartney' ]
		withErrorType: CantSuspend
		ifSoDo: [ :anError |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/23/2018 15:16:35'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| johnLennon |
	johnLennon _ 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	self
		shouldFail: [ customerBook suspendCustomerNamed: johnLennon ]
		withErrorType: CantSuspend
		ifSoDo: [ :anError |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'A 9/22/2018 16:53:56'!
assertBookHasASuspendedCustomer: aCustomerBook
	self
		assert: 1
		equals: aCustomerBook numberOfSuspendedCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'A 9/22/2018 16:54:38'!
assertBookHasAcustomer: aCustomerBook
	self
		assert: 1
		equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'A 9/22/2018 16:53:05'!
assertBookHasNoActiveCustomers: aCustomerBook
	self
		assert: 0
		equals: aCustomerBook numberOfActiveCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'A 9/22/2018 17:08:09'!
assertBookHasNoCustomers: aCustomerBook
	self
		assert: 0
		equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'A 9/22/2018 16:55:16'!
assertBookHasNoSuspendedCustomers: aCustomerBook
	self
		assert: 0
		equals: aCustomerBook numberOfSuspendedCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'A 9/22/2018 16:46:48'!
should: unBloque takeLessThan: unaCantidadDeMilisegundos
	| millisecondsBeforeRunning millisecondsAfterRunning |
	millisecondsBeforeRunning _ Time millisecondClockValue * millisecond.
	unBloque value.
	millisecondsAfterRunning _ Time millisecondClockValue * millisecond.
	^ self assert: millisecondsAfterRunning - millisecondsBeforeRunning < unaCantidadDeMilisegundos.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'A 9/23/2018 14:21:47'!
shouldCustomer: aCustomer beRemovedFromCustomerBook: aCustomerBook
	self assertBookHasNoActiveCustomers: aCustomerBook.
	self assertBookHasNoSuspendedCustomers: aCustomerBook.
	self assertBookHasNoCustomers: aCustomerBook.
	self deny: (aCustomerBook includesCustomerNamed: aCustomer).! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'A 9/23/2018 14:22:20'!
shouldCustomer: aCustomer notBeRemovedFromCustomerBook: aCustomerBook
	self assertBookHasNoActiveCustomers: aCustomerBook.
	self assertBookHasASuspendedCustomer: aCustomerBook.
	self assertBookHasAcustomer: aCustomerBook.
	self assert: (aCustomerBook includesCustomerNamed: aCustomer).! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'A 9/22/2018 16:47:43'!
shouldFail: unBloqueAFallar withErrorType: unTipoDeError ifSoDo: unBloqueAVerificar
	[
	unBloqueAFallar value.
	self fail ]
		on: unTipoDeError
		do: unBloqueAVerificar.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers suspended'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:28'!
includesCustomerNamed: aName

	^(customers includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:38'!
isEmpty
	
	^customers isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NicolasRinaldi 9/16/2018 21:55:33'!
initialize

	super initialize.
	customers := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'HAW 9/19/2018 08:41:11'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((customers includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:57'!
numberOfActiveCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NicolasRinaldi 9/16/2018 22:01:43'!
numberOfCustomers
	
	^customers size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'A 9/23/2018 15:20:25'!
removeCustomerNamed: aName 
 
	customers remove: aName ifAbsent: [suspended remove: aName ifAbsent: [^ NotFound signal]].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:27:55'!
suspendCustomerNamed: aName 
	
	(customers includes: aName) ifFalse: [^CantSuspend signal].
	
	customers remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
