!classDefinition: #I category: #'Quinta Actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Quinta Actividad'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:18:34'!
* unNumeroDePeano 
	^unNumeroDePeano .! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:16:13'!
- unNumeroDePeano

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados .! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 18:35:11'!
/ unNumeroDePeano
	(self = unNumeroDePeano) 
		ifTrue: [^self]
		ifFalse: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
		].! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 17:58:32'!
< unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^false].
	^true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 18:30:38'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:15:47'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se puede restar un numero menor a un numero mayor o igual'! !

!I class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:13:35'!
loVoyARestarA: unNumeroDePeano

	^unNumeroDePeano previous.! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !


!classDefinition: #II category: #'Quinta Actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Quinta Actividad'!
II class
	instanceVariableNames: 'prev next unNumeroDePeano'!

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:01:53'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano .! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:09:12'!
+ unNumeroDePeano
	^ self previous + unNumeroDePeano next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:16:34'!
- unNumeroDePeano

	^unNumeroDePeano loVoyARestarA: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 18:01:43'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	unNumeroDePeano = self ifTrue:[^I].
	unNumeroDePeano = I ifTrue: [^self].
	^(self - unNumeroDePeano /unNumeroDePeano) next! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 18:03:23'!
< unNumeroDePeano

	self = unNumeroDePeano ifTrue: [^false].
	self = I ifTrue: [^true].
	unNumeroDePeano = I ifTrue: [^false].
	^self previous < unNumeroDePeano previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 18:25:42'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:17:03'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	prev := I.
	next := III.
	unNumeroDePeano := nil.! !

!II class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:15:41'!
loVoyARestarA: unNumeroDePeano

	^unNumeroDePeano previous - self previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:10'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:32'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:09:12'!
previous
	^ prev.! !


!classDefinition: #III category: #'Quinta Actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Quinta Actividad'!
III class
	instanceVariableNames: 'next prev'!

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano .! !

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
+ unNumeroDePeano
	^ self previous + unNumeroDePeano next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:15:29'!
- unNumeroDePeano

	^unNumeroDePeano loVoyARestarA: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	unNumeroDePeano = self ifTrue:[^I].
	unNumeroDePeano = I ifTrue: [^self].
	^(self - unNumeroDePeano /unNumeroDePeano) next! !

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
< unNumeroDePeano

	self = unNumeroDePeano ifTrue: [^false].
	self = I ifTrue: [^true].
	unNumeroDePeano = I ifTrue: [^false].
	^self previous < unNumeroDePeano previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:17:03'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:15:52'!
loVoyARestarA: unNumeroDePeano

	^unNumeroDePeano previous - self previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
previous
	^ prev.! !


!classDefinition: #IIII category: #'Quinta Actividad'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Quinta Actividad'!
IIII class
	instanceVariableNames: 'next prev'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano .! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
+ unNumeroDePeano
	^ self previous + unNumeroDePeano next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:15:21'!
- unNumeroDePeano

	^unNumeroDePeano loVoyARestarA: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	unNumeroDePeano = self ifTrue:[^I].
	unNumeroDePeano = I ifTrue: [^self].
	^(self - unNumeroDePeano /unNumeroDePeano) next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
< unNumeroDePeano

	self = unNumeroDePeano ifTrue: [^false].
	self = I ifTrue: [^true].
	unNumeroDePeano = I ifTrue: [^false].
	^self previous < unNumeroDePeano previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:17:03'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:16:11'!
loVoyARestarA: unNumeroDePeano

	^unNumeroDePeano previous - self previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 19:33:50'!
previous
	^ prev.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!