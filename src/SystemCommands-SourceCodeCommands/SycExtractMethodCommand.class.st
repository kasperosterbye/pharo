"
I am a command to extract selected ast node into separate method 
"
Class {
	#name : #SycExtractMethodCommand,
	#superclass : #SycSourceCodeCommand,
	#instVars : [
		'selectedTextInterval'
	],
	#category : #'SystemCommands-SourceCodeCommands'
}

{ #category : #execution }
SycExtractMethodCommand class >> canBeExecutedInContext: aSourceCodeContext [
	super canBeExecutedInContext: aSourceCodeContext.
	
	^aSourceCodeContext isMethodSelected not 
]

{ #category : #converting }
SycExtractMethodCommand >> asRefactorings [
	| selectedInterval refactoring |
	selectedInterval := selectedTextInterval ifEmpty: [ 
		                    sourceNode sourceInterval ].
	refactoring := RBExtractMethodAndOccurrences
		               extract: selectedInterval
		               from: method selector
		               in: method origin.
	NautilusRefactoring new refactoringOptions: refactoring.
	self setUpOptionToUseExistingMethodDuring: refactoring.
	self setUpOptionToOverrideExistingMethodDuring: refactoring.
	self setUpOptionToChangeMethodNameDuring: refactoring.
	^ { refactoring }
	
]

{ #category : #accessing }
SycExtractMethodCommand >> defaultMenuIconName [ 
	^ #glamorousRestart
]

{ #category : #accessing }
SycExtractMethodCommand >> defaultMenuItemName [
	^ 'Extract method'
]

{ #category : #execution }
SycExtractMethodCommand >> execute [

	self executeRefactoring: self asRefactorings
]

{ #category : #testing }
SycExtractMethodCommand >> isComplexRefactoring [
	^ true
]

{ #category : #execution }
SycExtractMethodCommand >> readParametersFromContext: aSourceCodeContext [
	super readParametersFromContext: aSourceCodeContext.
	
	selectedTextInterval := aSourceCodeContext selectedTextInterval.
	
]

{ #category : #execution }
SycExtractMethodCommand >> setUpOptionToChangeMethodNameDuring: refactoring [

	| dialog |
	refactoring setOption: #methodName toUse: [ :ref :methodName | 
		dialog := SycMethodNameEditorPresenter
			          openOn: methodName
			          withRefactoring: ref.
		dialog cancelled ifTrue: [ CmdCommandAborted signal ].
		methodName ]
]

{ #category : #execution }
SycExtractMethodCommand >> setUpOptionToOverrideExistingMethodDuring: aRefactoring [

	aRefactoring setOption: #alreadyDefined toUse:  [ :ref :class :selector | 
		ref refactoringWarning: 'Method ', selector printString, ' will override method in ', class name]. 
]

{ #category : #execution }
SycExtractMethodCommand >> setUpOptionToUseExistingMethodDuring: aRefactoring [

	aRefactoring setOption: #useExistingMethod toUse:  [ :ref :selector | 
		UIManager default 
			confirm: 'Do you want to use existing method ', selector printString, '?'
			label: 'Warninig']. 	
	
]
