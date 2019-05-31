var safe = require './safe/safe-api.js'

tag Todo < li
	prop key
	prop idx

	def setup
		@isMutable = false
	
	def mutable
		@isMutable = true
	
	def immutable
		@isMutable = false

	def onchange
		if data:text == ""
			trigger('itemdelete', idx)
		else
			trigger('itemupdate', idx)

	def render
		<self css:display='flex'>
			<label css:flex='1'>
				<input[data:made] type="checkbox">
			<div :tap.mutable  css:flex='99' css:display='flex'>
				if !@isMutable
					<div .done=data:made> data:text
				else
					<input@condInput[data:text] :keyup.enter.immutable>
			<label css:padding='3px' css:text-decoration='default'> '[' + key + ']'

tag App
	prop production

	def setup
		
		@online = production
		@isSynced = false

		if @online
			@isInitialized = await safe.isSafeInitialised()
			data:items = await safe.getItems()
		else
			@isInitialized = true
			data:items = [
				{
					key: [49]
					value: {text: "Scotland to try Scotch whisky", made: false}
					version: 0
				}
				{
					key: [50]
					value: {text: "Patagonia before I'm too old", made: false}
					version: 0
				}
			]

		if data:items
			console.log data:items
			@isSynced = true

		var max = 0
		let keys = data:items:map do |item| item:key
		for k in keys
			if k > max
				max = Number(k)
		@nextKey = max + 1

		tick

	def addItem
		if @input.value
			@isSynced = false
			if @online
				await safe.insertItem(
					String(@nextKey),
					{
						text: @input.value
						made: false
					})
				data:items = await safe.getItems()
			else
				data:items.push({
					key: [@nextKey]
					value: {
						text: @input.value
						made: false
					}
					version: 0
				})
			@nextKey += 1
			@input.value = ""
			@isSynced = true
			render

	def onitemdelete e
		var idx = e.data
		console.log "delete item: " + idx
		@isSynced = false
		if @online
			await safe.deleteItems([data:items[idx]])
			data:items = await safe.getItems()
		else
			data:items.splice(idx,1)
		@isSynced = true
		tick

	def onitemupdate e
		var idx = e.data
		console.log "update item: " + idx
		@isSynced = false
		if @online
			await safe.updateItem(
				data:items[idx]:key,
				data:items[idx]:value,
				String(Number(data:items[idx]:version + 1)))
			data:items = await safe.getItems()
		@isSynced = true
		tick
	
	def render
		<self.vbox>
			<div.header css:background='grey' css:color='white'>
				<label css:padding='3px'> 'init: '
					if @isInitialized
						<span> '💚'
					else
						<span> '💛'
				if @isInitialized
					<label css:padding='3px'> 'sync: '
						if @isSynced
							<span> '💚'
						else
							<span> '💛'
					
			<form.header :submit.prevent.addItem>
				<input@input type='text' autofocus>
				<button> 'add'

			<ul css:height=200>
				for item,i in data:items
					<Todo[item:value] key=item:key[0] idx=i>

Imba.mount <App[{items: null}] production=false>
