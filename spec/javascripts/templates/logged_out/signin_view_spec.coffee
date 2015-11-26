fixture.preload("users.json")

describe 'signin view', ()->
	
	scope = null
	html = null
	ctrl = null
	compile = null
	view = null
	users = null

	beforeEach module('LoggedOutApp')
	beforeEach module('templates')
	beforeEach ()->
    	fixtures = fixture.load("users.json")
    	users = fixtures[0]
	

	setupController = ()->
		inject(($controller, $rootScope, $templateCache, $compile)->
			scope = $rootScope.$new()
			ctrl = $controller('SignupController', $scope: scope)
			compile = $compile
			html = $templateCache.get 'landing_page/_signin.html'
			view = $compile(angular.element(html))(scope)
			scope.$digest()
			)

	beforeEach setupController()

	
	describe 'view contains', ()->
		
		it 'should have email input', () ->
			expect(view.find("[name='session[email]']").length).toBe(1)

		it 'should have password input', () ->
			expect(view.find("[name='session[password]']").length).toBe(1)

		it 'should have remember me input', () ->
			expect(view.find("[name='session[remember_me]']").length).toBe(1)