!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'mc 9/30/2018 13:59:21'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'mc 9/30/2018 13:58:32'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'mc 9/30/2018 18:27:29'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:47'!
invalidNumberTypeErrorDescription
	^ 'Tipo de numero invalido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 20:06:21'!
* aMultiplier 

	^aMultiplier  multiplyAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 19:59:45'!
+ anAdder 

	^anAdder addToAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:42:28'!
- aSubtrahend

	^ aSubtrahend substractToAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:47:10'!
/ aDivisor 

	^aDivisor divideAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:58:02'!
// aDivisor 

	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 19:54:05'!
addToAFraction: aFraction

	| newNumerator newDenominator |
	
	newNumerator := self * aFraction denominator + aFraction numerator .
	newDenominator := aFraction denominator .
	
	^ newNumerator / newDenominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 19:44:00'!
addToAnEntero: anEntero

"
 	this will  return an SmallInteger and when it operates with other Numero will raise an exception
	
	^self integerValue + anEntero integerValue
"
	^ self class with: value + anEntero integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/27/2018 00:05:31'!
divideAFraction: aFraction

	^aFraction numerator/(aFraction denominator * self).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:48:25'!
divideAnEntero: anEntero

	^Fraccion with: anEntero over: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 10/1/2018 01:27:16'!
fibonacci

	^(NumeroTypeOperator typeFor: self) fibonacci.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:43:51'!
greatestCommonDivisorWith: anEntero 

	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 20:13:30'!
multiplyAFraction: aFraction

	^ aFraction numerator * self / aFraction denominator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 20:08:29'!
multiplyAnEntero: anEntero

	^ self class with: value * anEntero integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:35:46'!
substractToAFraction: aFraction


	| newNumerator newDenominator |
	newNumerator := aFraction numerator - (self  * aFraction denominator).
	newDenominator := aFraction denominator.
	^newNumerator / newDenominator ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 22:54:22'!
substractToAnEntero: anEntero

	^self class with: anEntero integerValue - value.! !


!Entero methodsFor: 'comparing' stamp: 'mc 9/27/2018 00:14:33'!
< aSmallInteger

	^value < aSmallInteger .! !

!Entero methodsFor: 'comparing' stamp: 'mc 9/27/2018 00:13:36'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'mc 9/30/2018 13:25:10'!
> aSmallInteger

	^value > aSmallInteger .! !

!Entero methodsFor: 'comparing' stamp: 'mc 9/27/2018 00:13:28'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'mc 9/27/2018 00:13:46'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'mc 9/27/2018 00:14:00'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'mc 9/27/2018 00:14:09'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'mc 9/27/2018 00:14:18'!
isOne

	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'mc 9/27/2018 00:14:25'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 9/23/2018 22:17:16'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para enteros negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'mc 10/1/2018 01:52:22'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	"aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ]."
	
	(TypeOperator operatorTypeFor: aValue ) operateAsInteger.
	^self new initalizeWith: aValue! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 20:11:35'!
* aMultiplier 

	^ aMultiplier multiplyAFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:58:54'!
+ anAdder 

	^anAdder  addToAFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:40:40'!
- aSubtrahend 

	^aSubtrahend substractToAFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/27/2018 00:01:56'!
/ aDivisor 

	^aDivisor divideAFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:14:22'!
addToAFraction: aFraction

	| newNumerator newDenominator |
	
	newNumerator := (aFraction numerator * denominator) + (aFraction denominator * numerator).
	newDenominator := aFraction denominator * denominator.
	
	^newNumerator /newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:27:00'!
addToAnEntero: anEntero

	^anEntero * denominator + numerator / denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/27/2018 00:07:32'!
divideAFraction: aFraction

	^(aFraction numerator * denominator) / (aFraction denominator * numerator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:53:12'!
divideAnEntero: anEntero

	^Fraccion with: anEntero * denominator over: numerator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:14:35'!
multiplyAFraction: aFraction

	^( numerator * aFraction numerator) / (denominator * aFraction denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:16:28'!
multiplyAnEntero: anEntero

	^ anEntero * numerator / denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:40:48'!
substractToAFraction: aFraction


	| newNumerator newDenominator |
 
	newNumerator := (aFraction numerator * denominator) - (aFraction denominator * numerator).
				newDenominator := aFraction denominator * denominator.
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'mc 9/26/2018 23:14:46'!
substractToAnEntero: anEntero

	^anEntero * denominator - numerator / denominator.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'mc 10/1/2018 01:27:16'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	(NumeroTypeOperator typeFor: aNumerator) canBeANumerator.
	(NumeroTypeOperator typeFor: aDenominator ) canBeADenominator.
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'mc 10/1/2018 01:27:16'!
with: aDividend over: aDivisor

"	| greatestCommonDivisor numerator denominator| "
	
	(NumeroTypeOperator typeFor:aDivisor) canBeADenominator.
	^(NumeroTypeOperator typeFor:aDividend) instanceFraccionAsDividendWith: aDivisor . ! !


!classDefinition: #TypeOperator category: #'Numero-Exercise'!
Object subclass: #TypeOperator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!TypeOperator methodsFor: 'operate' stamp: 'mc 10/1/2018 01:52:49'!
operateAsInteger

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TypeOperator class' category: #'Numero-Exercise'!
TypeOperator class
	instanceVariableNames: ''!

!TypeOperator class methodsFor: 'operator search' stamp: 'mc 10/1/2018 01:37:04'!
objectType: anObject

	self subclassResponsibility.! !

!TypeOperator class methodsFor: 'operator search' stamp: 'mc 10/1/2018 01:44:58'!
operatorTypeFor: anObject


| objectTypeClass |

	objectTypeClass _ self subclasses detect: [ :anObjectTypeClass | anObjectTypeClass objectType: anObject ].
	
	^ objectTypeClass new.! !


!classDefinition: #NumeroTypeOperator category: #'Numero-Exercise'!
TypeOperator subclass: #NumeroTypeOperator
	instanceVariableNames: 'numero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTypeOperator methodsFor: 'numero operations' stamp: 'mc 9/30/2018 13:36:53'!
fibonacci

	self subclassResponsibility.! !

!NumeroTypeOperator methodsFor: 'numero operations' stamp: 'mc 10/1/2018 01:15:10'!
instanceFraccionAsDividendWith: aDivisor

	self subclassResponsibility.! !

!NumeroTypeOperator methodsFor: 'numero operations' stamp: 'mc 10/1/2018 00:31:01'!
instanceFraccionAsDivisorWith: aDividend

	self subclassResponsibility.! !


!NumeroTypeOperator methodsFor: 'evaluation' stamp: 'mc 9/30/2018 13:15:27'!
canBeADenominator

	self subclassResponsibility.! !

!NumeroTypeOperator methodsFor: 'evaluation' stamp: 'mc 9/30/2018 12:34:35'!
canBeANumerator

	self subclassResponsibility.! !


!NumeroTypeOperator methodsFor: 'initialization' stamp: 'mc 9/30/2018 13:28:37'!
initializeFor: unNumero

	numero := unNumero. ! !


!NumeroTypeOperator methodsFor: 'operate' stamp: 'mc 10/1/2018 01:53:07'!
operateAsInteger
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NumeroTypeOperator class' category: #'Numero-Exercise'!
NumeroTypeOperator class
	instanceVariableNames: ''!

!NumeroTypeOperator class methodsFor: 'operator search' stamp: 'mc 10/1/2018 01:40:39'!
objectType: anObject

	^anObject  isInteger.! !


!NumeroTypeOperator class methodsFor: 'instance creation' stamp: 'mc 9/30/2018 13:02:39'!
for: unNumero

	^self new initializeFor: unNumero.! !


!NumeroTypeOperator class methodsFor: 'numero operator search' stamp: 'mc 9/30/2018 12:59:55'!
type: unNumero

	self subclassResponsibility.! !

!NumeroTypeOperator class methodsFor: 'numero operator search' stamp: 'mc 9/30/2018 14:13:25'!
typeFor: unNumero


| numerTypeClass |

	numerTypeClass _ self subclasses detect: [ :aNumeroTypeClass | aNumeroTypeClass type: unNumero ].
	
	^ numerTypeClass for: unNumero.! !


!classDefinition: #Cero category: #'Numero-Exercise'!
NumeroTypeOperator subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'evaluation' stamp: 'mc 9/30/2018 18:35:44'!
canBeADenominator

	self error: numero class canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'evaluation' stamp: 'mc 9/30/2018 20:16:08'!
canBeANumerator

	self error: 'una fraccion no puede ser cero'.! !


!Cero methodsFor: 'operations' stamp: 'mc 9/30/2018 13:42:41'!
fibonacci

	^ Entero with: 1.! !


!Cero methodsFor: 'fraccion instantiation' stamp: 'mc 10/1/2018 01:20:14'!
instanceFraccionAsDividendWith: aDivisor
	
	"caso --> aDividend isZero ifTrue: [ ^aDividend ]."

	^numero .! !

!Cero methodsFor: 'fraccion instantiation' stamp: 'mc 10/1/2018 00:34:44'!
instanceFraccionAsDivisorWith: aDividend

	self canBeADenominator.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: #'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'numero operator search' stamp: 'mc 9/30/2018 13:00:36'!
type: unNumero

	^unNumero isZero.! !


!classDefinition: #MayorAUno category: #'Numero-Exercise'!
NumeroTypeOperator subclass: #MayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!MayorAUno methodsFor: 'evaluation' stamp: 'mc 9/30/2018 13:18:22'!
canBeADenominator! !

!MayorAUno methodsFor: 'evaluation' stamp: 'mc 9/30/2018 20:13:04'!
canBeANumerator! !


!MayorAUno methodsFor: 'operations' stamp: 'mc 9/30/2018 14:05:33'!
fibonacci

	| one two |
	
	one _ Entero with: 1.
	two _ Entero with: 2.
	
	^ (numero - one) fibonacci + (numero - two) fibonacci.! !


!MayorAUno methodsFor: 'fraccion instantiation' stamp: 'mc 10/1/2018 01:23:39'!
instanceFraccionAfterDivideByCMAsDivisorWith: aDividend

	"caso (self =Fraccion)--> ^self new initializeWith: numerator over: denominator."

	^Fraccion new initializeWith: aDividend over: numero.! !

!MayorAUno methodsFor: 'fraccion instantiation' stamp: 'mc 10/1/2018 01:27:16'!
instanceFraccionAsDividendWith: aDivisor

	^(NumeroTypeOperator typeFor:aDivisor) instanceFraccionAsDivisorWith: numero.! !

!MayorAUno methodsFor: 'fraccion instantiation' stamp: 'mc 10/1/2018 01:27:16'!
instanceFraccionAsDivisorWith: aDividend

 | greatestCommonDivisor numerator denominator |

	greatestCommonDivisor := aDividend greatestCommonDivisorWith: numero. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := numero // greatestCommonDivisor.
	
	^(NumeroTypeOperator typeFor:denominator) instanceFraccionAfterDivideByCMAsDivisorWith: numerator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MayorAUno class' category: #'Numero-Exercise'!
MayorAUno class
	instanceVariableNames: ''!

!MayorAUno class methodsFor: 'numero operator search' stamp: 'mc 9/30/2018 13:22:18'!
type: unNumero

	^unNumero > 1.! !


!classDefinition: #Negativo category: #'Numero-Exercise'!
NumeroTypeOperator subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'evaluation' stamp: 'mc 9/30/2018 13:32:00'!
canBeADenominator! !

!Negativo methodsFor: 'evaluation' stamp: 'mc 9/30/2018 20:14:11'!
canBeANumerator! !


!Negativo methodsFor: 'operations' stamp: 'mc 9/30/2018 13:43:03'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription.! !


!Negativo methodsFor: 'fraccion instantiation' stamp: 'mc 10/1/2018 01:27:16'!
instanceFraccionAsDividendWith: aDivisor

	^(NumeroTypeOperator typeFor:aDivisor) instanceFraccionAsDivisorWith: numero.! !

!Negativo methodsFor: 'fraccion instantiation' stamp: 'mc 10/1/2018 01:21:25'!
instanceFraccionAsDivisorWith: aDividend

	"caso --> aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated]."
	
	^aDividend negated / numero negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativo class' category: #'Numero-Exercise'!
Negativo class
	instanceVariableNames: ''!

!Negativo class methodsFor: 'numero operator search' stamp: 'mc 9/30/2018 13:32:16'!
type: unNumero

	^unNumero < 0.! !


!classDefinition: #Uno category: #'Numero-Exercise'!
NumeroTypeOperator subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'evaluation' stamp: 'mc 9/30/2018 13:18:00'!
canBeADenominator

	self error: 'una fraccion no puede tener denominador 1 porque sino es un entero'.! !

!Uno methodsFor: 'evaluation' stamp: 'mc 9/30/2018 20:15:29'!
canBeANumerator! !


!Uno methodsFor: 'operations' stamp: 'mc 9/30/2018 13:43:25'!
fibonacci

	^Entero with: 1.! !


!Uno methodsFor: 'fraccion instantiation' stamp: 'mc 10/1/2018 00:49:14'!
instanceFraccionAfterDivideByCMAsDivisorWith: aDividend

	^self instanceFraccionAsDivisorWith: aDividend .! !

!Uno methodsFor: 'fraccion instantiation' stamp: 'mc 10/1/2018 01:27:16'!
instanceFraccionAsDividendWith: aDivisor

	^(NumeroTypeOperator typeFor:aDivisor) instanceFraccionAsDivisorWith: numero.! !

!Uno methodsFor: 'fraccion instantiation' stamp: 'mc 10/1/2018 01:23:00'!
instanceFraccionAsDivisorWith: aDividend

	"caso --> denominator isOne ifTrue: [ ^numerator ]."
	^aDividend.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: #'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'numero operator search' stamp: 'mc 9/30/2018 13:19:12'!
type: unNumero

	^unNumero isOne.! !


!classDefinition: #OtherTypeOperator category: #'Numero-Exercise'!
TypeOperator subclass: #OtherTypeOperator
	instanceVariableNames: 'numero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!OtherTypeOperator methodsFor: 'operate' stamp: 'mc 10/1/2018 01:53:33'!
operateAsInteger
	
	self error: 'aValue debe ser anInteger'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OtherTypeOperator class' category: #'Numero-Exercise'!
OtherTypeOperator class
	instanceVariableNames: ''!

!OtherTypeOperator class methodsFor: 'operator-search' stamp: 'mc 10/1/2018 01:49:16'!
objectType: anObject

	^anObject  isInteger not.! !
