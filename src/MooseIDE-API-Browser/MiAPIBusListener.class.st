"
This is a ""fake"" browser with the purpose of following a bus (either for client or provider entities) and inform the related `MiAPIModel` when it receives entities

The whole thing so that `MiAPIBrowser` can follow 2 buses
"
Class {
	#name : 'MiAPIBusListener',
	#superclass : 'MiAbstractBrowser',
	#instVars : [
		'methods'
	],
	#category : 'MooseIDE-API-Browser-Model',
	#package : 'MooseIDE-API-Browser',
	#tag : 'Model'
}

{ #category : 'testing' }
MiAPIBusListener >> canFollowEntity: anObject [

	^anObject isCollection
		ifTrue:  [ anObject anySatisfy: [ :each | self canFollowEntity: each ] ]
		ifFalse: [ anObject usesFamixTrait: TEntityMetaLevelDependency ]
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

	application defaultBus: defaultBus.

]

{ #category : 'debugging actions' }
MiAPIBusListener >> terminate [
	"there should be only on MiBus in #buses
	 but we can as well prepare for the worse"

	[ buses isEmpty ]
		whileFalse: [ self unfollowBus ]
]

{ #category : 'actions' }
MiAPIBusListener >> unfollowBus [

	self currentBus ifNotNil: [ :currentBus |
		self unfollowBus: currentBus ].

]
