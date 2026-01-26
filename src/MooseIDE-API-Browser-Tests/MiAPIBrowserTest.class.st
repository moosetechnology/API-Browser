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

	self skip: 'currently not handling entity selection and re-propagation'
]

{ #category : 'tests - buses' }
MiAPIBrowserTest >> testFollowBusSetsDefaultBus [

	self skip: 'Different Bus behavior for this browser'
]

{ #category : 'tests - settings' }
MiAPIBrowserTest >> testSettingsAction [

	self assert: browser hasSettings
]
