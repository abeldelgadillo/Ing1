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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 19:39:37'!
assertEstadoDe: aCustomerBook conClienteSuspendido: aCustomer

	self assertNoHayClientesActivos: aCustomerBook.
	self assertHayUnClienteSuspendido: aCustomerBook.
	self assertHayUnCliente: aCustomerBook.
	self assert: (aCustomerBook includesCustomerNamed: aCustomer).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 17:54:28'!
assertHayUnCliente: aCustomerBook
	self
		assert: 1
		equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 17:55:10'!
assertHayUnClienteSuspendido: aCustomerBook
	self
		assert: 1
		equals: aCustomerBook numberOfSuspendedCustomers.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 18:02:06'!
assertNoHayClientes: aCustomerBook

	self assert: 0 equals: aCustomerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 17:56:49'!
assertNoHayClientesActivos: aCustomerBook
	self
		assert: 0
		equals: aCustomerBook numberOfActiveCustomers.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 18:01:18'!
assertNoHayClientesSuspendidos: aCustomerBook

	self assert: 0 equals: aCustomerBook numberOfSuspendedCustomers.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 19:41:01'!
checkEstadoDeLibro: aCustomerBook conClienteSuspendido: aCustomer
	self assertNoHayClientesActivos: aCustomerBook.
	self assertHayUnClienteSuspendido: aCustomerBook.
	self assertHayUnCliente: aCustomerBook.
	self assert: (aCustomerBook includesCustomerNamed: aCustomer).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 19:44:35'!
checkEstadoDeLibro: aCustomerBook sinClientes: aCustomer
	self assertNoHayClientesActivos: aCustomerBook.
	self assertNoHayClientesSuspendidos: aCustomerBook.
	self assertNoHayClientes: aCustomerBook.
	self deny: (aCustomerBook includesCustomerNamed: aCustomer).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 18:17:07'!
deberia: unBloque ejecutarseEnMenosDe: unaCantidadDeMilisegundos
	| millisecondsBeforeRunning millisecondsAfterRunning |
	millisecondsBeforeRunning _ Time millisecondClockValue * millisecond.
	unBloque value.
	millisecondsAfterRunning _ Time millisecondClockValue * millisecond.
	^ self assert: millisecondsAfterRunning - millisecondsBeforeRunning < unaCantidadDeMilisegundos.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 18:07:35'!
esperarFallaDe: unBloqueAFallar conUnErrorDeTipo: unTipoDeError siOcurreHacer: unBloqueAVerificar
	[
	unBloqueAFallar value.
	self fail ]
		on: unTipoDeError
		do: unBloqueAVerificar.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 18:17:07'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook |
	customerBook _ CustomerBook new.
	self
		deberia: [ customerBook addCustomerNamed: 'John Lennon' ]
		ejecutarseEnMenosDe: 50 * millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 18:17:07'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney |
	customerBook _ CustomerBook new.
	paulMcCartney _ 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	self
		deberia: [ customerBook removeCustomerNamed: paulMcCartney ]
		ejecutarseEnMenosDe: 100 * millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 18:07:35'!
test03CanNotAddACustomerWithEmptyName
	| customerBook |
	customerBook _ CustomerBook new.
	self
		esperarFallaDe: [ customerBook addCustomerNamed: '' ]
		conUnErrorDeTipo: Error
		siOcurreHacer: [ :anError |
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 18:07:35'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |
	customerBook _ CustomerBook new.
	johnLennon _ 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self
		esperarFallaDe: [ customerBook removeCustomerNamed: 'Paul McCartney' ]
		conUnErrorDeTipo: NotFound
		siOcurreHacer: [ :anError |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 19:41:01'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney |
	customerBook _ CustomerBook new.
	paulMcCartney _ 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	self
		checkEstadoDeLibro: customerBook
		conClienteSuspendido: paulMcCartney.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 19:44:35'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook paulMcCartney |
	customerBook _ CustomerBook new.
	paulMcCartney _ 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	self
		checkEstadoDeLibro: customerBook
		sinClientes: paulMcCartney.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 18:07:35'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook johnLennon |
	customerBook _ CustomerBook new.
	johnLennon _ 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self
		esperarFallaDe: [ customerBook suspendCustomerNamed: 'Paul McCartney' ]
		conUnErrorDeTipo: CantSuspend
		siOcurreHacer: [ :anError |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'A 9/21/2018 18:07:35'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| customerBook johnLennon |
	customerBook _ CustomerBook new.
	johnLennon _ 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	self
		esperarFallaDe: [ customerBook suspendCustomerNamed: johnLennon ]
		conUnErrorDeTipo: CantSuspend
		siOcurreHacer: [ :anError |
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].! !


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

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 9/19/2018 08:41:50'!
removeCustomerNamed: aName 
 
	1 to: customers size do: 
	[ :index |
		aName = (customers at: index)
			ifTrue: [
				customers removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

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
