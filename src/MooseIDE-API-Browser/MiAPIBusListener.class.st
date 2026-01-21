"
This is a ""fake"" browser with the purpose of following a bus (either for client or provider entities) and inform the related `MiAPIModel` when it receives entities

The whole thing so that `MiAPIBrowser` can follow 2 buses
"
Class {
	#name : 'MiAPIBusListener',
	#superclass : 'MiAbstractVisualizationBrowser',
	#instVars : [
		'methods',
		'myBus'
	],
	#category : 'MooseIDE-API-Browser-browser',
	#package : 'MooseIDE-API-Browser',
	#tag : 'browser'
}

{ #category : 'testing' }
MiAPIBusListener >> canFollowEntity: anObject [

	^anObject isMooseObject
]

{ #category : 'accessing' }
MiAPIBusListener >> currentBus [
	"there should be only one MiBus attached to this BusListener"

	^buses ifEmpty: [ nil ] ifNotEmpty: [ buses anyOne ]
]

{ #category : 'actions' }
MiAPIBusListener >> followEntity: entity [

	methods := entity isCollection
		ifTrue: [ entity flatCollect: [ :e |
			e containedEntitiesOfType: FamixTMethod ] ]
		ifFalse: [
			entity containedEntitiesOfType: FamixTMethod ].

	specModel runVisualization 
]

{ #category : 'accessing' }
MiAPIBusListener >> methods [

	^methods ifNil: [ ^#() ]
]

{ #category : 'accessing' }
MiAPIBusListener >> onBus: aMiBus [

	| defaultBus |
	(self currentBus = aMiBus)  ifTrue: [ ^self ].
	
	defaultBus := application defaultBus.

	self unfollowBus.
	self followBus: aMiBus.

	application defaultBus: aMiBus.

]

{ #category : 'actions' }
MiAPIBusListener >> unfollowBus [

	self currentBus ifNotNil: [ :currentBus |
		self unfollowBus: currentBus ].

]
