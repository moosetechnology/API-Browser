Class {
	#name : 'MiAPIBusListenerTest',
	#superclass : 'MiAbstractApplicationTest',
	#instVars : [
		'listener'
	],
	#category : 'MooseIDE-API-Browser-Tests',
	#package : 'MooseIDE-API-Browser-Tests'
}

{ #category : 'running' }
MiAPIBusListenerTest >> setUp [

	super setUp.

	listener := MiAPIBusListener new
]

{ #category : 'running' }
MiAPIBusListenerTest >> tearDown [ 

	listener terminate.

	super tearDown.
]

{ #category : 'tests' }
MiAPIBusListenerTest >> testCanFollowEntity [

	self assert: (listener canFollowEntity: FamixStPackage new).
	self assert: (listener canFollowEntity: FamixStClass new).
	self assert: (listener canFollowEntity: FamixStMethod new).

	"Not sure about this one should it be accepted or refused ?
	self deny: (listener canFollowEntity: FamixStParameter new)".
	self deny: (listener canFollowEntity: FamixStSourceAnchor new)
]

{ #category : 'tests' }
MiAPIBusListenerTest >> testOnBusKeepsDefaultBus [

	| oldBus newBus |
	oldBus := application defaultBus.
	newBus := application busNamed: 'aNewBus'.
	"Creating a new bus sets it as the default one"
	self assert: application defaultBus equals: newBus.

	listener onBus: oldBus.
	self assert: application defaultBus equals: newBus.

]

{ #category : 'tests' }
MiAPIBusListenerTest >> testOnBusRegistersInBus [

	| aBus |
	aBus := application defaultBus.
	
	self assert: aBus browsers size equals: 0.

	listener onBus: aBus.
	self assert: aBus browsers size equals: 1.
	self assert: aBus browsers anyOne equals: listener 
]

{ #category : 'tests' }
MiAPIBusListenerTest >> testOnBusSetsCurrentBus [

	self assert: listener currentBus equals: nil.

	listener onBus: application defaultBus.
	self assert: listener currentBus equals: application defaultBus.

]

{ #category : 'tests' }
MiAPIBusListenerTest >> testOnBusUnregistersPreviousBus [

	| oldBus newBus |
	oldBus := application defaultBus.
	newBus := application busNamed: 'aNewBus'.

	listener onBus: oldBus.
	self assert: oldBus browsers size equals: 1.
	self assert: newBus browsers size equals: 0.

	listener onBus: newBus.
	self assert: oldBus browsers size equals: 0.
	self assert: newBus browsers size equals: 1.
]

{ #category : 'tests' }
MiAPIBusListenerTest >> testUnFollowBus [

	| aBus |
	aBus := application defaultBus.

	listener onBus: aBus.
	self assert: aBus browsers size equals: 1.

	listener unfollowBus .
	self assert: aBus browsers size equals: 0
]

{ #category : 'tests' }
MiAPIBusListenerTest >> testUnregisterOnClose [

	| aBus |
	aBus := application defaultBus.

	listener onBus: application defaultBus.
	self assert: listener currentBus equals: aBus.
	self assert: aBus browsers size equals: 1.

	listener terminate.
	self assert: listener currentBus equals: nil.
	self assert: aBus browsers size equals: 0.
]
