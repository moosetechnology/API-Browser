"
A visualization showing dependencies between 2 ""subsystems"" (client and provider)
This is specialized for OO systems and expect three level of entities: Package/Class/Method
Differently to other browsers, this one has 2 buses on which it receives the entities of each ""subsystem""

Accepted entities: (on each bus) Source entities that are either methods or method containers

Use:
- Launch it,
- optionnaly set the buses to listen in ""Settings""
- propagate entities of each ""subsystem"" on the correct bus
"
Class {
	#name : 'MiAPIBrowser',
	#superclass : 'MiAbstractVisualizationBrowser',
	#category : 'MooseIDE-API-Browser-browser',
	#package : 'MooseIDE-API-Browser',
	#tag : 'browser'
}

{ #category : 'accessing' }
MiAPIBrowser class >> mapClass [

	^ MiAPIVisualization 
]

{ #category : 'world menu' }
MiAPIBrowser class >> menuCommandOn: aBuilder [

	<worldMenu>
	<miBrowsersMenu>
	^ self buildMenuItemIn: aBuilder
]

{ #category : 'world menu' }
MiAPIBrowser class >> menuItem [

	^ #APIBrowser
]

{ #category : 'world menu' }
MiAPIBrowser class >> menuLabel [

	^ 'API Browser'
]

{ #category : 'world menu' }
MiAPIBrowser class >> menuPriority [

	^ self menuVisualizationToolsPriority + 5
]

{ #category : 'instance creation' }
MiAPIBrowser class >> newModel [

	^ MiAPIMapModel new
]

{ #category : 'instance creation' }
MiAPIBrowser class >> open [

	<script>
	^super open
		finishedInitialization ;
		yourself
]

{ #category : 'specs' }
MiAPIBrowser class >> title [

	^ 'API explorer'
]

{ #category : 'interactions' }
MiAPIBrowser >> addToSelection: entities [
	"Add to currently selected shapes all shapes for entities"

	| shapesToHighlight shapesHighlighted |

	shapesHighlighted := self canvas selectedShapes ifNil: [ #(  ) ].
	shapesToHighlight := self shapesFromModels: entities.

	self canvas setSelectedShapes: shapesToHighlight , shapesHighlighted
]

{ #category : 'window control' }
MiAPIBrowser >> browserClosed [

	super browserClosed.

	specModel closingBrowser
]

{ #category : 'testing' }
MiAPIBrowser >> canFollowEntity: anObject [

	^anObject isMooseObject
]

{ #category : 'accessing' }
MiAPIBrowser >> canvas [

	^mainPresenter canvas
]

{ #category : 'accessing' }
MiAPIBrowser >> defaultNodeStyle [

	^MiArchitecturalMapStyle new
]

{ #category : 'actions' }
MiAPIBrowser >> finishedInitialization [

	specModel runVisualization 
]

{ #category : 'actions' }
MiAPIBrowser >> followEntity: anEntity [
	"Do not do anything here
	 This browser has 2 buses and receiving entities is handled by 2 `MiAPIBusListner_s"
]

{ #category : 'accessing' }
MiAPIBrowser >> getMooseModel: aMooseObject [

	aMooseObject isMooseModel ifTrue: [ ^aMooseObject ].
	aMooseObject isCollection  ifTrue: [ ^aMooseObject anyOne mooseModel ].
	^aMooseObject mooseModel
]

{ #category : 'testing' }
MiAPIBrowser >> hasSettings [

	^true
]

{ #category : 'testing' }
MiAPIBrowser >> isFullyInitialized [

	specModel ifNil: [ ^false ].
	mainPresenter ifNil: [ ^false ].

	^true
]

{ #category : 'accessing' }
MiAPIBrowser >> linkShapesFromModels: associations [

	| linkShapes |
	linkShapes := self canvas shapes select: #isLine.

	^ associations collect: [ :assoc |
			  | shapeFrom shapeTo |
			  shapeFrom := self canvas shapeFromModel:
				               (assoc key cacheAt: #p16APIHNode).
			  shapeTo := self canvas shapeFromModel:
				             (assoc value cacheAt: #p16APIHNode).

			  linkShapes detect: [ :link |
				  link from = shapeFrom and: [ link to = shapeTo ] ] ]
]

{ #category : 'accessing' }
MiAPIBrowser >> miSelectedItem [

	mainPresenter ifNil: [ ^#() ].

	^super miSelectedItem
]

{ #category : 'accessing' }
MiAPIBrowser >> nodeShapesFromModels: famixEntities [

	^ self canvas shapesFromModels:
		  (famixEntities collect: [ :fmx | fmx cacheAt: #p16APIHNode ])
]

{ #category : 'interactions' }
MiAPIBrowser >> removeFromSelection: entities [
	"Remove from currently selected shapes those representing #entities"

	| shapesToUnhighlight shapesHighlighted |

	shapesHighlighted := self canvas selectedShapes ifNil: [ #() ].
	shapesToUnhighlight := self shapesFromModels: entities.

	self canvas setSelectedShapes: (shapesHighlighted \ shapesToUnhighlight)
]

{ #category : 'accessing' }
MiAPIBrowser >> shapesFromModels: famixEntities [
	"note: both lists or sets, but we cannot use concatenation on sets :-(
	   so we make an OrderedCollection of it"

	^(self nodeShapesFromModels: (famixEntities reject: [ :fmx | fmx isAssociation ])) ,
	(self linkShapesFromModels: (famixEntities select: [ :fmx | fmx isAssociation ]))
	
]
