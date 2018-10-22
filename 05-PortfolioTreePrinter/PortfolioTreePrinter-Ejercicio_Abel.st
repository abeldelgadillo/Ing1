!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 18:48:48'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'A 10/20/2018 14:12:18'!
describiteEn: aSummary conMensaje: aString

	^aSummary addLast: aString, self value printString! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'A 10/20/2018 13:21:10'!
register: aValue on: account

	self subclassResponsibility.! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value period interesRate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:49:34'!
affect: sum

	^sum - value.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'A 10/22/2018 15:30:09'!
describiteEn: aSummary

	^aSummary addLast: 'Plazo fijo por ', value printString, ' durante ', period printString, ' dias a una tna de ', (interesRate *100) printString, '%'.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:56:15'!
esCertificado
	^true.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 19:01:06'!
esTransferencia

	^false.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 18:49:12'!
hacerCuenta: sum

	^sum + (value*((interesRate)/360)*period).! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 18:47:23'!
initializeWith: aValue during: aPeriod at: anInteresRate on: aReceptiveAccount

	value := aValue.
	period := aPeriod.
	interesRate := anInteresRate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:31:05'!
of: aSmallInteger during: aSmallInteger2 at: aFraction on: aReceptiveAccount 

	|certificate|

	certificate := self new initializeWith: aSmallInteger during: aSmallInteger2 at: aFraction on: aReceptiveAccount.
	
	aReceptiveAccount register: certificate.
	
	^certificate.! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'A 10/20/2018 16:48:35'!
affect: currentBalance

	^currentBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 14:01:05'!
describiteEn: anOrderedCollection 

	self describiteEn: anOrderedCollection conMensaje: 'Deposito por '! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:55:29'!
esCertificado
	^false.! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 14:22:45'!
esTransferencia
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #DepositLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #DepositLeg
	instanceVariableNames: 'transfer value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:09:46'!
affect: sum

	^sum + value.! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 14:13:57'!
describiteEn: anOrderedCollection 

	self describiteEn: anOrderedCollection conMensaje: 'Transferencia por '! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:04:10'!
esTransferencia

	^true.! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:17:17'!
initializeFor: aTransfer 
	
	transfer := aTransfer .
	value := transfer value.! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:44:36'!
knows: aTransfer 
	
	^transfer = aTransfer .! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:57:46'!
transfer
	^transfer! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:45:29'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
DepositLeg class
	instanceVariableNames: ''!

!DepositLeg class methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:16:51'!
for: aTransfer 
	
	^self new initializeFor: aTransfer .! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'A 10/20/2018 14:14:08'!
describiteEn: anOrderedCollection 

	self describiteEn: anOrderedCollection conMensaje: 'Extraccion por '! !

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'A 10/20/2018 16:48:43'!
affect: currentBalance

	^currentBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:55:39'!
esCertificado
	^false.! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 14:22:55'!
esTransferencia
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #WithdrawLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #WithdrawLeg
	instanceVariableNames: 'transfer value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:06:44'!
affect: sum

	^sum - value.! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 14:17:28'!
describiteEn: anOrderedCollection 

	self describiteEn: anOrderedCollection conMensaje: 'Transferencia por -'! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:55:47'!
esCertificado
	^false.! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 14:23:08'!
esTransferencia
	^true! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:22:13'!
initializeFor: aTransfer 

	transfer := aTransfer .
	value := transfer value.! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:56:08'!
knows: aTransfer 
	
	^transfer = aTransfer.! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:58:08'!
transfer
	^transfer! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 14:16:46'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
WithdrawLeg class
	instanceVariableNames: ''!

!WithdrawLeg class methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:25:13'!
for: aTransfer 
	
	^self new initializeFor: aTransfer .! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 10/18/2018 16:31:24'!
transactionsOf: anAccount 

	^ (self doesManage: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HAW 10/18/2018 16:31:24'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount doesManage: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'A 10/20/2018 16:35:57'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction affect: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 14:00:11'!
accountSummary
	
	^transactions inject: OrderedCollection new into: [:summary :transaction | transaction describiteEn: summary . summary].! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:36:13'!
accountTransferNet
	
	|collection|
	
	collection := transactions select: [:transaction | transaction esTransferencia].
	
	^collection inject: 0 into: [:suma :transaction | transaction affect: suma].! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 18:38:32'!
investmentEarnings
	
	|collection|
	
	collection := transactions select: [:transaction | transaction esCertificado].
	
	^collection inject: 0 into: [:suma :transaction | transaction hacerCuenta: suma].! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 16:59:18'!
investmentNet
	
	|collection|
	
	collection := transactions select: [:transaction | transaction esCertificado].
	
	^(collection inject: 0 into: [:suma :transaction | transaction affect: suma]) * -1.! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:40:58'!
allDepositLegsFrom: aReceptiveAccount to: aReceptiveAccount2 
	self shouldBeImplemented.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:55:43'!
allLegsOfType: aClass From: aReceptiveAccount to: aReceptiveAccount3 
	
	|collection1 collection2|

	collection1 := (from transactions select: [:transaction | transaction isKindOf: aClass]).
	collection2 := (to transactions select: [:transaction | transaction isKindOf: aClass]).
	
	collection1 addAll: collection2.
	
	^collection1.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:36:02'!
depositLeg
	
	^self detectKnownTransferLegOfType: DepositLeg.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:42:19'!
detectKnownTransferLegOfType: aClass 
	
	|collection|
	
	collection _ self allLegsOfType: aClass From: from to: to.
	
	^collection detect: [:transaction | transaction knows: self]! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:16:16'!
initializeWith: aSmallInteger from: aReceptiveAccount to: aReceptiveAccount3 
	
	value := aSmallInteger .
	from := aReceptiveAccount .
	to := aReceptiveAccount3 .! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:28:46'!
value

	^value.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:46:28'!
withdrawLeg
	
	^self detectKnownTransferLegOfType: WithdrawLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'A 10/20/2018 13:15:30'!
register: aSmallInteger from: fromReceptiveAccount to: toReceptiveAccount 

	|transfer|
	
	transfer := Transfer new initializeWith: aSmallInteger from: fromReceptiveAccount to: toReceptiveAccount.
	
	toReceptiveAccount register: (DepositLeg for: transfer).
	fromReceptiveAccount register: (WithdrawLeg for: transfer).
	
	^transfer.! !
