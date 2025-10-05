Class {
	#name : 'BaselineOfAPIBrowser',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAPIBrowser',
	#package : 'BaselineOfAPIBrowser'
}

{ #category : 'baselines' }
BaselineOfAPIBrowser >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec description: 'API Browser'.
		"self defineDependencies: spec."
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : 'baselines' }
BaselineOfAPIBrowser >> defineGroups: spec [

	spec
		group: 'default' with: #( 'MooseIDE-API-Browser' )
]

{ #category : 'baselines' }
BaselineOfAPIBrowser >> definePackages: spec [

	spec
		package: 'MooseIDE-API-Browser'

]
