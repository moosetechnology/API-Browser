Class {
	#name : 'MiAPIBrowserTest',
	#superclass : 'MiAbstractBrowserTest',
	#category : 'MooseIDE-API-Browser-Tests',
	#package : 'MooseIDE-API-Browser-Tests'
}

{ #category : 'running' }
MiAPIBrowserTest >> browserClass [

	^ MiAPIBrowser 
]

{ #category : 'running' }
MiAPIBrowserTest >> clientBus [

	^browser specModel clientBus 
]

{ #category : 'running' }
MiAPIBrowserTest >> populateBrowser: mooseModel [

	| clientMethod providerMethod |

	clientMethod := mooseModel newMethodNamed: 'clientMethod'.
	clientMethod parentType: (mooseModel newClassNamed: 'clientClass').
	clientMethod parentType typeContainer: (mooseModel newPackageNamed: 'clientPackage').

	providerMethod := mooseModel newMethodNamed: 'providerMethod'.
	providerMethod parentType: (mooseModel newClassNamed: 'providerClass').
	providerMethod parentType typeContainer: (mooseModel newPackageNamed: 'providerPackage').

	mooseModel newInvocation
		sender: clientMethod ;
		candidates: { providerMethod }.

	self clientBus globallySelect: (mooseModel entityNamed: 'clientPackage').
	self providerBus globallySelect: (mooseModel entityNamed: 'providerPackage').

]

{ #category : 'running' }
MiAPIBrowserTest >> providerBus [

	^browser specModel providerBus 
]

{ #category : 'tests' }
MiAPIBrowserTest >> testActivateActionButtons [

	self skip: 'currently not handling entity selection, inspection, or propagation'
]

{ #category : 'tests - settings' }
MiAPIBrowserTest >> testLayers [
	"check that the model has the correct layers after propagatin entities to the buses"

	| mooseModel |
	mooseModel := FamixStModel new.
	self populateBrowser: mooseModel.

	self assert: browser specModel srcPackageLayer size equals: 1.
	self assert: browser specModel srcPackageLayer anyOne name equals: 'clientPackage'.

	self assert: browser specModel srcClassLayer size equals: 1.
	self assert: browser specModel srcClassLayer anyOne name equals: 'clientClass'.

	self assert: browser specModel srcMethodLayer size equals: 1.
	self assert: browser specModel srcMethodLayer anyOne name equals: 'clientMethod'.

	self assert: browser specModel tgtPackageLayer size equals: 1.
	self assert: browser specModel tgtPackageLayer anyOne name equals: 'providerPackage'.

	self assert: browser specModel tgtClassLayer size equals: 1.
	self assert: browser specModel tgtClassLayer anyOne name equals: 'providerClass'.

	self assert: browser specModel tgtMethodLayer size equals: 1.
	self assert: browser specModel tgtMethodLayer anyOne name equals: 'providerMethod'.
]

{ #category : 'tests - settings' }
MiAPIBrowserTest >> testSettingsAction [

	self assert: browser hasSettings
]

{ #category : 'tests - settings' }
MiAPIBrowserTest >> testUnregisterFromBusOnClose [

	| clientBus providerBus |
	clientBus := MiAPIMapModel defaultClientBus.
	providerBus := MiAPIMapModel defaultProviderBus.

	self assert: clientBus browsers size equals: 2. "browser and MiBusListener"
	self assert: browser specModel clientBus equals: clientBus.

	self assert: providerBus browsers size equals: 1. "MiBusListener"
	self assert: browser specModel providerBus equals: providerBus.

	browser window close.
	self assert: browser specModel clientBus equals: nil.
	self assert: browser specModel providerBus equals: nil.
	self assert: clientBus browsers size equals: 0.
	self assert: providerBus browsers size equals: 0

]
