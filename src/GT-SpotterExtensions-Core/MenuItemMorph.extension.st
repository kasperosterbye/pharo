Extension { #name : #MenuItemMorph }

{ #category : #'*GT-SpotterExtensions-Core' }
MenuItemMorph class >> gtExampleMenuItemMorphWithSubitems [
	<gtExample>
	<label: 'Menu item with subitems'>
	
	^ self currentWorld worldMenu items 
		detect: [ :each | each contents = 'System' ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
MenuItemMorph class >> gtExampleMenuItemMorphWithoutSubitems [
	<gtExample>
	<label: 'Menu item without subitems'>
	
	^ self currentWorld worldMenu items 
		detect: [ :each | each contents = 'System Browser' ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
MenuItemMorph >> spotterActDefault [
	self doButtonAction
]

{ #category : #'*GT-SpotterExtensions-Core' }
MenuItemMorph >> spotterPreviewMenuIn: aComposite [
	<spotterPreview: 10>
	
	aComposite list
		title: [ self contents ];
		display: #yourself;
		format: [ :item | 
			GTSpotterItemBrick new 
				text: item contents; 
				icon: item icon; 
				disable;
				yourself ];
		styled: [ :brick | brick ];
		entity: (self hasSubMenu ifFalse: [ {self} ] ifTrue: [ self subMenu allItems ]).
		
	self flag: 'move "entity: self" somewhere else, maybe'
]
