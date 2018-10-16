!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'A 10/14/2018 13:48:18'!
sumarA: suma

	^suma + self value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !

!Withdraw methodsFor: 'initialization' stamp: 'A 10/14/2018 13:48:42'!
sumarA: suma

	^suma - self value.! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #SummarizingAccount category: #'Portfolio-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'A 10/16/2018 17:26:43'!
balance

	^accounts inject: 0 into: [:balance :account | balance + account balance].! !


!Portfolio methodsFor: 'testing' stamp: 'mc 10/15/2018 21:35:36'!
doesManage: anAccount

	 ^anAccount  iAmManagedBy: self.! !

!Portfolio methodsFor: 'testing' stamp: 'A 10/14/2018 14:11:50'!
hasRegistered: aTransaction

	^accounts anySatisfy: [:account | account hasRegistered: aTransaction ].! !

!Portfolio methodsFor: 'testing' stamp: 'mc 10/15/2018 21:25:50'!
iAmManagedBy: aPorfolio

	^aPorfolio manageAnyEqualAccount: self.! !

!Portfolio methodsFor: 'testing' stamp: 'mc 10/15/2018 21:19:29'!
iAmTheManagerOf: anAccount

	^accounts anySatisfy: [:account | account = anAccount or: (account doesManage: anAccount)].! !

!Portfolio methodsFor: 'testing' stamp: 'A 10/15/2018 13:50:52'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts.! !

!Portfolio methodsFor: 'testing' stamp: 'A 10/16/2018 17:27:05'!
manageAnyEqualAccount: aPorfolio

	^(self allManagedAccounts) anySatisfy: [ :aReceptiveAccount | 
										(aPorfolio doesManage: aReceptiveAccount )].! !


!Portfolio methodsFor: 'transactions' stamp: 'A 10/15/2018 12:19:04'!
transactions 

	^accounts inject: OrderedCollection new into: [:transactionsOfPortfolio :account | 
		transactionsOfPortfolio addAll: account transactions.
		transactionsOfPortfolio.]! !

!Portfolio methodsFor: 'transactions' stamp: 'A 10/15/2018 13:47:24'!
transactionsOf: anAccount 

	^(self doesManage: anAccount) 
	ifTrue: [anAccount transactions.] 
	ifFalse: [self error: self class accountNotManagedMessageDescription]! !


!Portfolio methodsFor: 'private' stamp: 'mc 10/15/2018 21:44:07'!
allManagedAccounts
	
	| allReceptive |
	allReceptive _ OrderedCollection  new.
	
	accounts do:[ :anAccount | allReceptive addAll: (anAccount allManagedAccounts)].
	
	^allReceptive .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'A 10/15/2018 14:00:10'!
with: leftAccount with: rightAccount

	^((leftAccount doesManage: rightAccount) or:(rightAccount doesManage: leftAccount)) 
	ifTrue: [self error: self accountAlreadyManagedErrorMessage] 
	ifFalse: [self withAll: (Array with: leftAccount with: rightAccount)].! !

!Portfolio class methodsFor: 'instance creation' stamp: 'A 10/15/2018 13:55:07'!
withAll: aCollectionOfAccounts

	^self new initializeWithAll: aCollectionOfAccounts.! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:43'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:53'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'A 10/14/2018 13:46:49'!
balance

	^transactions inject: 0 into: [:balance :transaction | transaction sumarA: balance].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'mc 10/15/2018 21:18:52'!
iAmManagedBy: aPorfolio

	^aPorfolio iAmTheManagerOf: self.
! !


!ReceptiveAccount methodsFor: 'private' stamp: 'mc 10/15/2018 21:46:07'!
allManagedAccounts
	
	^ OrderedCollection with: self.! !
