fixture.preload("users.json")

describe 'SignupController', ()->
	
	scope = null
	ctrl = null
	httpBackend = null
	fixtures = null
	headers_check = null
	users = null

	beforeEach module('LoggedOutApp')
	beforeEach ()->
    	fixtures = fixture.load("users.json")
    	users = fixtures[0]
	

	setupController = ()->
		inject ($controller, $rootScope, $templateCache, $compile, $httpBackend)->
			scope = $rootScope.$new()
			ctrl = $controller('SignupController', $scope: scope)
			httpBackend = $httpBackend
			httpBackend.whenGET('/users/check_email?email=example@example.org').respond(200, users[0])
			httpBackend.whenGET(/^\/users\/check_email\?email\=.*/).respond(200, null)


	beforeEach setupController()

	it 'should find users', () ->
		expect(scope.user).toBe(null)
		scope.check_email("example@example.org")
		httpBackend.flush()
		expect(scope.user.id).toBe(1)

	it 'should not find users', () ->
		scope.user = null
		expect(scope.user).toBe(null)
		scope.check_email("exPmple@example.org")
		httpBackend.flush()
		expect(scope.user.id).toBe(undefined)