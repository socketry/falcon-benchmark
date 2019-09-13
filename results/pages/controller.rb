
prepend Actions

on '*' do |request, path|
	@name = path.components.last || 'small'
	
	path.components = ["index"]
end