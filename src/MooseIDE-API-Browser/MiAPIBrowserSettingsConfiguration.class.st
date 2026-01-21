"
Handler of settings for MiAPIBrowser
"
Class {
	#name : 'MiAPIBrowserSettingsConfiguration',
	#superclass : 'MiAbstractSettingsConfiguration',
	#instVars : [
		'accessedPrefix',
		'clientPrefix',
		'providerBus',
		'clientBus'
	],
	#category : 'MooseIDE-API-Browser-settings',
	#package : 'MooseIDE-API-Browser',
	#tag : 'settings'
}

{ #category : 'accessing' }
MiAPIBrowserSettingsConfiguration >> accessedPrefix [

	^ accessedPrefix
]

{ #category : 'accessing' }
MiAPIBrowserSettingsConfiguration >> accessedPrefix: anObject [

	accessedPrefix := anObject
]

{ #category : 'accessing' }
MiAPIBrowserSettingsConfiguration >> clientBus [

	^clientBus
]

{ #category : 'accessing' }
MiAPIBrowserSettingsConfiguration >> clientBus: anObject [

	clientBus := anObject
]

{ #category : 'accessing' }
MiAPIBrowserSettingsConfiguration >> clientPrefix [

	^ clientPrefix
]

{ #category : 'accessing' }
MiAPIBrowserSettingsConfiguration >> clientPrefix: anObject [

	clientPrefix := anObject
]

{ #category : 'accessing' }
MiAPIBrowserSettingsConfiguration >> providerBus [

	^ providerBus
]

{ #category : 'accessing' }
MiAPIBrowserSettingsConfiguration >> providerBus: anObject [

	providerBus := anObject
]

{ #category : 'ui' }
MiAPIBrowserSettingsConfiguration >> settingsPresenters [

	^{
	(MiDroplistSettingPresenter on: self)
		label: 'Provider bus' ;
	   help: 'The bus containing provider entities.' ;
	   items: (MiApplication current buses) ;
	   display: [ :aBus | aBus name ];
		selectItem: self providerBus ;
	   whenSelectedDo: [ :aBus | self providerBus: aBus ] ;
		yourself
	.
	(MiDroplistSettingPresenter on: self)
		label: 'Client bus' ;
	   help: 'The bus containing client entities.' ;
	   items: (MiApplication current buses) ;
	   display: [ :aBus | aBus name ];
		selectItem: self clientBus ;
	   whenSelectedDo: [ :aBus | self providerBus: aBus ] ;
		yourself
	}
]
