"
I am a processor that gets all the help topics in the system.
"
Class {
	#name : #StHelpProcessor,
	#superclass : #StCollectionBasedProcessor,
	#category : #'NewTools-Spotter-Processors-Processors'
}

{ #category : #'default-settings' }
StHelpProcessor class >> defaultEnabled [

	^ true
]

{ #category : #accessing }
StHelpProcessor class >> order [
	
	^ 2000
]

{ #category : #accessing }
StHelpProcessor class >> title [

	^ 'Help topics'
]

{ #category : #filtering }
StHelpProcessor >> collection [

	^ SystemHelp asHelpTopic gtAllSubtopics
]

{ #category : #'key-bindings' }
StHelpProcessor >> installKeymappingsOn: aPresenter [

	aPresenter
		bindKeyCombination: $h meta
		toAction: [ aPresenter onKeyProcessor: self ]
]

{ #category : #filtering }
StHelpProcessor >> newEntryOn: anElement [

	^ StHelpEntry on: anElement
]

{ #category : #configuration }
StHelpProcessor >> showForEmptyQuery [ 

	^ true
]
