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

!I class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:07:19'!
esRestadoPor: unNumeroDePeano

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
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:01:53'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano .! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:09:12'!
+ unNumeroDePeano
	^ self previous + unNumeroDePeano next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:04:09'!
- unNumeroDePeano

"	unNumeroDePeano = I ifTrue: [^self prev].

	^self prev - unNumeroDePeano prev"
	^unNumeroDePeano esRestadoPor: self.! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:06:03'!
esRestadoPor: unNumeroDePeano

	^unNumeroDePeano previous - self previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 18:55:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := I.! !

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

II initializeAfterFileIn!