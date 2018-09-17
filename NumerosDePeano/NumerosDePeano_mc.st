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

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:27:16'!
* unNumeroDePeano 

	^unNumeroDePeano .! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:27:25'!
- unNumeroDePeano

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados .! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:27:29'!
/ unNumeroDePeano

	^unNumeroDePeano dividirAlPrimerNumeroDePeano.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 18:30:38'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 12:15:47'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se puede restar un numero menor a un numero mayor o igual'! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 11:45:55'!
dividirA: unNumeroDePeano

	^unNumeroDePeano.! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 11:17:00'!
dividirAlPrimerNumeroDePeano

	^I! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 11:22:54'!
dividirPor: unNumeroDePeano conCociente: cocienteEnPeano

	^cocienteEnPeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:00:20'!
hacerRestaPorDivision: unNumeroDePeano

	^unNumeroDePeano hacerRestaPorDivisionConUno! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:13:32'!
hacerRestaPorDivisionConUno
	
	^I! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 15:46:28'!
hacerRestaPorDivisionSinError: unNumeroDePeano
	^I.! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 13:21:37'!
loVoyARestarA: unNumeroDePeano

	^unNumeroDePeano previous.! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:27:03'!
next

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 13:21:51'!
restarPorDivisionA: unNumeroDePeano

	^unNumeroDePeano previous.! !

!I class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 15:58:56'!
restarPorDivisionSinErrorA: unNumeroDePeano

	^unNumeroDePeano previous.! !


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

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:07:11'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano .! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:07:18'!
+ unNumeroDePeano

	^ self previous + unNumeroDePeano next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:16:34'!
- unNumeroDePeano

	^unNumeroDePeano loVoyARestarA: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:08:33'!
/ unNumeroDePeano

	^unNumeroDePeano dividirA: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 9/15/2018 18:25:42'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:06:50'!
dividirA: unNumeroDePeano

	^self dividirA: (unNumeroDePeano hacerRestaPorDivision: self) conCociente: I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:07:02'!
dividirA: unNumeroDePeano conCociente: cocienteEnPeano

	^(unNumeroDePeano hacerRestaPorDivisionSinError: self) dividirPor: self  conCociente: (cocienteEnPeano +I).! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 11:17:51'!
dividirAlPrimerNumeroDePeano

	^ I error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 15:29:43'!
dividirPor: unNumeroDePeano conCociente: cocienteEnPeano
	
	^unNumeroDePeano dividirA: self conCociente: cocienteEnPeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 14:46:24'!
hacerRestaPorDivision: unNumeroDePeano

	^unNumeroDePeano restarPorDivisionA: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:05:24'!
hacerRestaPorDivisionConUno
	
	^ self error: self  descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 15:55:31'!
hacerRestaPorDivisionSinError: unNumeroDePeano

	^unNumeroDePeano restarPorDivisionSinErrorA: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:30:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'matias 9/15/2018 20:15:41'!
loVoyARestarA: unNumeroDePeano

	^unNumeroDePeano previous - self previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:28:07'!
next

	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:28:13'!
prev: unNumeroDePeano


	prev _ unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:28:19'!
previous

	^ prev.! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 15:01:24'!
restarPorDivisionA: unNumeroDePeano

	^unNumeroDePeano previous hacerRestaPorDivision: self previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'mc 9/16/2018 15:56:52'!
restarPorDivisionSinErrorA: unNumeroDePeano

	^unNumeroDePeano previous hacerRestaPorDivisionSinError: self previous.! !


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

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano .! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
+ unNumeroDePeano
	^ self previous + unNumeroDePeano next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
- unNumeroDePeano

	^unNumeroDePeano loVoyARestarA: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
/ unNumeroDePeano

	^unNumeroDePeano dividirA: self.
		
	"
	Antigua Implementacion
	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	unNumeroDePeano = self ifTrue:[^I].
	unNumeroDePeano = I ifTrue: [^self].
	^(self - unNumeroDePeano /unNumeroDePeano) next
	"! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
dividirA: unNumeroDePeano

"	self = unNumeroDePeano ifTrue: [^I]."
	"^(unNumeroDePeano hacerRestaPorDivision: self) dividirPor: self  conCociente: I."
	^self dividirA: (unNumeroDePeano hacerRestaPorDivision: self) conCociente: I.
	 	
"
	unNumeroDePeano < self ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	^self dividirA: (unNumeroDePeano -self) conCociente: I. 
"! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
dividirA: unNumeroDePeano conCociente: cocienteEnPeano

	"self = unNumeroDePeano ifTrue: [^cocienteEnPeano +I]."
	"^ (unNumeroDePeano hacerRestaPorDivision: self conCociente:cocienteEnPeano) conCociente:(cocienteEnPeano +I)."
	^(unNumeroDePeano hacerRestaPorDivisionSinError: self) dividirPor: self  conCociente: (cocienteEnPeano +I).! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
dividirAlPrimerNumeroDePeano

	^ I error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
dividirPor: unNumeroDePeano conCociente: cocienteEnPeano
	
	^unNumeroDePeano dividirA: self conCociente: cocienteEnPeano.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
hacerRestaPorDivision: unNumeroDePeano

	^unNumeroDePeano restarPorDivisionA: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
hacerRestaPorDivisionConUno
	
	^ self error: self  descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
hacerRestaPorDivisionSinError: unNumeroDePeano

	^unNumeroDePeano restarPorDivisionSinErrorA: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:30:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
loVoyARestarA: unNumeroDePeano

	^unNumeroDePeano previous - self previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
previous
	^ prev.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
restarPorDivisionA: unNumeroDePeano

	^unNumeroDePeano previous hacerRestaPorDivision: self previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:48'!
restarPorDivisionSinErrorA: unNumeroDePeano

	^unNumeroDePeano previous hacerRestaPorDivisionSinError: self previous.! !


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

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
* unNumeroDePeano

	^self previous * unNumeroDePeano + unNumeroDePeano .! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
+ unNumeroDePeano
	^ self previous + unNumeroDePeano next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
- unNumeroDePeano

	^unNumeroDePeano loVoyARestarA: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
/ unNumeroDePeano

	^unNumeroDePeano dividirA: self.
		
	"
	Antigua Implementacion
	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	unNumeroDePeano = self ifTrue:[^I].
	unNumeroDePeano = I ifTrue: [^self].
	^(self - unNumeroDePeano /unNumeroDePeano) next
	"! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
dividirA: unNumeroDePeano

"	self = unNumeroDePeano ifTrue: [^I]."
	"^(unNumeroDePeano hacerRestaPorDivision: self) dividirPor: self  conCociente: I."
	^self dividirA: (unNumeroDePeano hacerRestaPorDivision: self) conCociente: I.
	 	
"
	unNumeroDePeano < self ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	^self dividirA: (unNumeroDePeano -self) conCociente: I. 
"! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
dividirA: unNumeroDePeano conCociente: cocienteEnPeano

	"self = unNumeroDePeano ifTrue: [^cocienteEnPeano +I]."
	"^ (unNumeroDePeano hacerRestaPorDivision: self conCociente:cocienteEnPeano) conCociente:(cocienteEnPeano +I)."
	^(unNumeroDePeano hacerRestaPorDivisionSinError: self) dividirPor: self  conCociente: (cocienteEnPeano +I).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
dividirAlPrimerNumeroDePeano

	^ I error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
dividirPor: unNumeroDePeano conCociente: cocienteEnPeano
	
	^unNumeroDePeano dividirA: self conCociente: cocienteEnPeano.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
hacerRestaPorDivision: unNumeroDePeano

	^unNumeroDePeano restarPorDivisionA: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
hacerRestaPorDivisionConUno
	
	^ self error: self  descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
hacerRestaPorDivisionSinError: unNumeroDePeano

	^unNumeroDePeano restarPorDivisionSinErrorA: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 14:30:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
loVoyARestarA: unNumeroDePeano

	^unNumeroDePeano previous - self previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
previous
	^ prev.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
restarPorDivisionA: unNumeroDePeano

	^unNumeroDePeano previous hacerRestaPorDivision: self previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'mc 9/17/2018 01:32:49'!
restarPorDivisionSinErrorA: unNumeroDePeano

	^unNumeroDePeano previous hacerRestaPorDivisionSinError: self previous.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!