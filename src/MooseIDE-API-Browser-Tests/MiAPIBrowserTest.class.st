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
MiAPIBrowserTest >> bus [
	"Should not be necessary, but the APIBrowser messes with buses out of ordinary
	 So trying to ensure we are on safe groung.
	 This is called by setup to set the defautlBus"

	^ self application busNamed: self application class defaultBusName
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

{ #category : 'tests - buses' }
MiAPIBrowserTest >> testFollowOtherBus [
	"Must redefine this test because of the way APIBrowser handles buses"

	| otherBus oldDefaultBus |
	self skip: #TODO.
	
	oldDefaultBus := self bus.
	otherBus := self application busNamed: 'Other bus'.
	browser followBus: otherBus.

	self assert: browser buses size equals: 2.

	self
		assertCollection: browser buses
		hasSameElements: {
			oldDefaultBus .
			otherBus .
			MiAPIMapModel defaultProviderBus
		}. 

	self assert: (oldDefaultBus browsers includes: browser).
	self assert: (self bus browsers includes: browser).

	self assert: browser busButton label equals: '2 buses'
]

{ #category : 'tests - settings' }
MiAPIBrowserTest >> testSettingsAction [

	self assert: browser hasSettings
]
