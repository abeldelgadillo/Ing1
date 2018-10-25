!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 18:48:48'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visiting' stamp: 'mc 10/22/2018 21:17:06'!
accept

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value duration interes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'initialization' stamp: 'mc 10/22/2018 21:11:11'!
initializeFor:aValue during:numberDays at:interesRate .

	value _ aValue. "(aValue * interesRate  * numberDays ) ."
	duration _ numberDays.
	interes _ interesRate .! !


!CertificateOfDeposit methodsFor: 'value' stamp: 'mc 10/22/2018 21:01:46'!
affectBalance: currentBalance

	^currentBalance - value.! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'mc 10/22/2018 20:49:15'!
value

	^value.! !


!CertificateOfDeposit methodsFor: 'accessing' stamp: 'mc 10/23/2018 19:05:53'!
duration

	^duration.! !

!CertificateOfDeposit methodsFor: 'accessing' stamp: 'mc 10/23/2018 19:06:03'!
interes

	^interes.! !


!CertificateOfDeposit methodsFor: 'visiting' stamp: 'mc 10/23/2018 18:41:27'!
accept: aVisitor

	^aVisitor visitACertificateOfDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'mc 10/22/2018 20:45:47'!
for: value during: numberDays at: interesRate

	^self new initializeFor:value during:numberDays at:interesRate .! !

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'mc 10/22/2018 20:44:17'!
register: aValue during: numberDays at: interesRate on: anAccount 
	
	| certificate |
	
	certificate := self for: aValue during: numberDays at: interesRate .
	anAccount register: certificate.
		
	^ certificate.! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:00'!
affectBalance: currentBalance

	^currentBalance + value! !

!Deposit methodsFor: 'value' stamp: 'mc 10/18/2018 19:50:00'!
value

	^ value! !


!Deposit methodsFor: 'visiting' stamp: 'mc 10/22/2018 23:58:42'!
accept: aVisitor

	^aVisitor visitADeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'mc 10/18/2018 20:01:40'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'mc 10/18/2018 19:47:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferLeg methodsFor: 'initialization' stamp: 'mc 10/21/2018 22:08:48'!
initializeVia: aTransfer

	transfer := aTransfer ! !


!TransferLeg methodsFor: 'accessing' stamp: 'mc 10/21/2018 22:15:37'!
transfer

	^ transfer.! !

!TransferLeg methodsFor: 'accessing' stamp: 'mc 10/21/2018 22:14:48'!
value

	^ transfer value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'mc 10/21/2018 22:13:48'!
registerVia: aTransfer

	^ self new initializeVia: aTransfer.! !


!classDefinition: #DepositLeg category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!DepositLeg methodsFor: 'value' stamp: 'mc 10/21/2018 20:26:14'!
affectBalance: currentBalance

	^currentBalance + self value! !


!DepositLeg methodsFor: 'visiting' stamp: 'mc 10/22/2018 23:58:52'!
accept: aVisitor

	^aVisitor visitADepositLeg: self.! !


!classDefinition: #WithdrawLeg category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WithdrawLeg methodsFor: 'value' stamp: 'mc 10/21/2018 20:27:40'!
affectBalance: currentBalance

	^currentBalance - self value! !


!WithdrawLeg methodsFor: 'visiting' stamp: 'mc 10/22/2018 23:59:02'!
accept: aVisitor

	^aVisitor visitAWithdrawLeg: self.! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:08'!
affectBalance: currentBalance

	^currentBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'visiting' stamp: 'mc 10/22/2018 23:59:10'!
accept: aVisitor

	^aVisitor visitAWithdraw: self.! !

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


!classDefinition: #PortfolioTree category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #PortfolioTree
	instanceVariableNames: 'portfolio names'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTree methodsFor: 'initialization' stamp: 'mc 10/25/2018 14:27:54'!
initializeWith: aPortfolio and: aDictionary 

	portfolio _ aPortfolio.
	names _ aDictionary .! !


!PortfolioTree methodsFor: 'private' stamp: 'mc 10/25/2018 14:18:18'!
spaces: aSmallInteger

	^(String new: aSmallInteger ) atAllPut: $ ! !


!PortfolioTree methodsFor: 'visiting' stamp: 'mc 10/25/2018 16:07:53'!
visitAPortfolio: aPortfolio with: accountList  from: aLevel
	
	| treeList |

	treeList _ OrderedCollection new.
	
	treeList  add: ((self spaces:aLevel) , (names at:aPortfolio )).
	
	^accountList inject: treeList into:[ :list :aReceptiveAccount |  list addAll: (aReceptiveAccount accept: self from: aLevel +1). list].
		
	"
	^treeList.
	"! !

!PortfolioTree methodsFor: 'visiting' stamp: 'mc 10/25/2018 15:00:08'!
visitAnAccount: anAccount  from: aLevel

	^OrderedCollection with: ((self spaces: aLevel ) , (names at:anAccount )).! !


!PortfolioTree methodsFor: 'value' stamp: 'mc 10/25/2018 15:45:03'!
print

	| lineList |
	
	lineList _ OrderedCollection new.

	lineList  addAll: (portfolio accept: self from: 0 ).
	
	^lineList .! !

!PortfolioTree methodsFor: 'value' stamp: 'mc 10/25/2018 15:47:24'!
reversePrint

	^self print reverse.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTree class' category: #'PortfolioTreePrinter-Ejercicio'!
PortfolioTree class
	instanceVariableNames: ''!

!PortfolioTree class methodsFor: 'as yet unclassified' stamp: 'mc 10/25/2018 14:52:48'!
for: aPortfolio namingWith: aDictionary

	^self new initializeWith: aPortfolio and: aDictionary.! !


!classDefinition: #ReceptiveAccountDescriptor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #ReceptiveAccountDescriptor
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccountDescriptor methodsFor: 'as yet unclassified' stamp: 'mc 10/22/2018 20:20:40'!
value

	self subclassResponsibility.! !


!classDefinition: #AccountSummaryLines category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountDescriptor subclass: #AccountSummaryLines
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummaryLines methodsFor: 'visiting' stamp: 'mc 10/23/2018 19:07:36'!
visitACertificateOfDeposit: aCertificate

	^'Plazo fijo por ', aCertificate value printString, ' durante ', aCertificate duration printString, ' dias a una tna de ', (aCertificate interes *100) printString, '%'. 
	! !

!AccountSummaryLines methodsFor: 'visiting' stamp: 'mc 10/22/2018 23:44:00'!
visitADeposit: deposit

	^'Deposito por ' append: deposit value asString.! !

!AccountSummaryLines methodsFor: 'visiting' stamp: 'mc 10/22/2018 23:48:12'!
visitADepositLeg: depositLeg

	^'Transferencia por ' append: depositLeg value asString! !

!AccountSummaryLines methodsFor: 'visiting' stamp: 'mc 10/22/2018 23:45:20'!
visitAWithdraw: withdraw

	^'Extraccion por ' append: withdraw value asString.! !

!AccountSummaryLines methodsFor: 'visiting' stamp: 'mc 10/22/2018 23:46:29'!
visitAWithdrawLeg: withdrawLeg

	^'Transferencia por -' append: withdrawLeg value asString! !


!AccountSummaryLines methodsFor: 'initialization' stamp: 'mc 10/22/2018 20:04:07'!
initializeWith: aReceptiveAccount

	account _ aReceptiveAccount .! !


!AccountSummaryLines methodsFor: 'value' stamp: 'mc 10/25/2018 15:48:01'!
value

	^account transactions inject: OrderedCollection new into: [:summary :transaction | 
																				summary add: (transaction accept: self). summary].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryLines class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummaryLines class
	instanceVariableNames: ''!

!AccountSummaryLines class methodsFor: 'as yet unclassified' stamp: 'mc 10/22/2018 20:03:17'!
for: aReceptiveAccount

	^self new initializeWith: aReceptiveAccount .! !


!classDefinition: #AccountTransferNet category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountDescriptor subclass: #AccountTransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNet methodsFor: 'visiting' stamp: 'mc 10/23/2018 19:10:23'!
visitACertificateOfDeposit: aCertificate

	^0! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'mc 10/23/2018 01:09:25'!
visitADeposit: aDeposit

	^0! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'mc 10/23/2018 01:04:51'!
visitADepositLeg: depositLeg

	^depositLeg value.
						! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'mc 10/23/2018 01:09:31'!
visitAWithdraw: withdraw

	^0! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'mc 10/23/2018 01:18:09'!
visitAWithdrawLeg: withdrawLeg

	^ withdrawLeg value negated.

	! !


!AccountTransferNet methodsFor: 'initialization' stamp: 'mc 10/22/2018 20:17:35'!
initializeWith: aReceptiveAccount

	account _ aReceptiveAccount .! !


!AccountTransferNet methodsFor: 'value' stamp: 'mc 10/25/2018 15:49:34'!
value

	^account transactions inject: 0 into: [:transferSum :transaction |  transferSum + (transaction accept: self)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'as yet unclassified' stamp: 'mc 10/22/2018 20:17:35'!
for: aReceptiveAccount

	^self new initializeWith: aReceptiveAccount .! !


!classDefinition: #InvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountDescriptor subclass: #InvestmentEarnings
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarnings methodsFor: 'visiting' stamp: 'mc 10/23/2018 19:12:23'!
visitACertificateOfDeposit: aCertificate

	^ aCertificate value*(aCertificate interes/360)* aCertificate duration .! !

!InvestmentEarnings methodsFor: 'visiting' stamp: 'mc 10/23/2018 18:45:28'!
visitADeposit: aDeposit

	^0! !

!InvestmentEarnings methodsFor: 'visiting' stamp: 'mc 10/23/2018 18:45:28'!
visitADepositLeg: aDepositLeg
	^0! !

!InvestmentEarnings methodsFor: 'visiting' stamp: 'mc 10/23/2018 18:45:28'!
visitAWithdraw: aWithdrawLeg

	^ 0.! !

!InvestmentEarnings methodsFor: 'visiting' stamp: 'mc 10/23/2018 18:45:28'!
visitAWithdrawLeg: aWithdrawLeg

	^ 0.! !


!InvestmentEarnings methodsFor: 'initialization' stamp: 'mc 10/23/2018 18:45:28'!
initializeWith: aReceptiveAccount

	account _ aReceptiveAccount .! !


!InvestmentEarnings methodsFor: 'value' stamp: 'mc 10/25/2018 15:50:29'!
value

	^account transactions inject: 0 into: [:investmentSum :transaction |  investmentSum + (transaction accept: self)].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentEarnings class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentEarnings class
	instanceVariableNames: ''!

!InvestmentEarnings class methodsFor: 'as yet unclassified' stamp: 'mc 10/23/2018 18:45:28'!
for: aReceptiveAccount

	^self new initializeWith: aReceptiveAccount .! !


!classDefinition: #InvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountDescriptor subclass: #InvestmentNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNet methodsFor: 'visiting' stamp: 'mc 10/23/2018 18:40:55'!
visitACertificateOfDeposit: aCertificate

	^ aCertificate value.! !

!InvestmentNet methodsFor: 'visiting' stamp: 'mc 10/23/2018 18:32:38'!
visitADeposit: aDeposit

	^0! !

!InvestmentNet methodsFor: 'visiting' stamp: 'mc 10/23/2018 18:33:23'!
visitADepositLeg: aDepositLeg
	^0! !

!InvestmentNet methodsFor: 'visiting' stamp: 'mc 10/23/2018 18:38:51'!
visitAWithdraw: aWithdrawLeg

	^ 0.! !

!InvestmentNet methodsFor: 'visiting' stamp: 'mc 10/23/2018 18:40:24'!
visitAWithdrawLeg: aWithdrawLeg

	^ 0.! !


!InvestmentNet methodsFor: 'initialization' stamp: 'mc 10/22/2018 20:53:45'!
initializeWith: aReceptiveAccount

	account _ aReceptiveAccount .! !


!InvestmentNet methodsFor: 'value' stamp: 'mc 10/25/2018 15:51:20'!
value

	^account transactions inject: 0 into: [:investmentSum :transaction |  investmentSum + (transaction accept: self)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentNet class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentNet class
	instanceVariableNames: ''!

!InvestmentNet class methodsFor: 'as yet unclassified' stamp: 'mc 10/22/2018 20:55:24'!
for: aReceptiveAccount

	^self new initializeWith: aReceptiveAccount .! !


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


!SummarizingAccount methodsFor: 'visiting' stamp: 'mc 10/25/2018 15:39:41'!
accept: aVisitior from: aLevel

	self subclassResponsibility .! !


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


!Portfolio methodsFor: 'visiting' stamp: 'mc 10/25/2018 15:06:27'!
accept: aVisitior from: aLevel

	^aVisitior  visitAPortfolio: self with: accounts copy from: aLevel.! !

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


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 10/18/2018 18:49:23'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction affectBalance: balance ]! !

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


!ReceptiveAccount methodsFor: 'visiting' stamp: 'mc 10/25/2018 15:03:25'!
accept: aVisitior from: aLevel

	^aVisitior  visitAnAccount: self from:aLevel  ! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'accessing' stamp: 'mc 10/18/2018 19:50:54'!
depositLeg

	^depositLeg.! !

!Transfer methodsFor: 'accessing' stamp: 'mc 10/21/2018 22:12:46'!
value

  ^ value.! !

!Transfer methodsFor: 'accessing' stamp: 'mc 10/18/2018 19:50:16'!
withdrawLeg

	^withdrawLeg.! !


!Transfer methodsFor: 'initialization' stamp: 'mc 10/21/2018 22:12:20'!
initializeFor: aSmallInteger from: fromAccount to: toAccount 
	
	value _ aSmallInteger.
	withdrawLeg _ WithdrawLeg registerVia: self.
	fromAccount  register: withdrawLeg .
	depositLeg _ DepositLeg  registerVia: self.
	toAccount  register: depositLeg .
	! !

!Transfer methodsFor: 'initialization' stamp: 'mc 10/18/2018 20:16:17'!
initializeWith: aWithdraw and: aDeposit 
	
	withdrawLeg _ aWithdraw .
	depositLeg _ aDeposit .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'mc 10/21/2018 22:00:50'!
register: aValue from:fromAccount to: toAccount 

"
	| transaction withdraw deposit |
	
	deposit _ Deposit register: aValue on: toAccount .
	withdraw _ Withdraw register: aValue on: fromAccount .
	
	transaction _ self withdrawLeg: withdraw  depositLeg: deposit .
"	
	^  self new initializeFor: aValue from: fromAccount to: toAccount .! !

!Transfer class methodsFor: 'instance creation' stamp: 'mc 10/18/2018 20:14:56'!
withdrawLeg: aWithdraw  depositLeg: aDeposit .
	
	^ self new initializeWith: aWithdraw  and:aDeposit.! !
