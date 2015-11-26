fixture.preload("users.json")

describe 'signup_view', ()->
	
	scope = null
	html = null
	ctrl = null
	compile = null
	view = null
	httpBackend = null
	users = null
	password_input = null
	email_input = null

	beforeEach module('LoggedOutApp')
	beforeEach module('templates')
	beforeEach ()->
    	fixtures = fixture.load("users.json")
    	users = fixtures[0]
	

	setupController = ()->
		inject(($controller, $rootScope, $templateCache, $compile, $httpBackend)->
			scope = $rootScope.$new()
			ctrl = $controller('SignupController', $scope: scope)
			compile = $compile
			html = $templateCache.get 'landing_page/_signup.html'
			view = $compile(angular.element(html))(scope)
			scope.$digest()
			httpBackend = $httpBackend
			httpBackend.whenGET('/users/check_email?email=l2silver@ryerson.ca').respond(200, {response: true})
			httpBackend.whenGET(/^\/users\/check_email\?email\=.*/).respond(200, null)
			)

	beforeEach setupController()

	
	describe 'view contains', ()->

		it 'should have email input', () ->
			expect(view.find("[name='email']").length).toBe(1)

		it 'should have password input', () ->
			expect(view.find("[name='password']").length).toBe(1)

	describe 'email input', ()->
		
		beforeEach ()->
			email_input = view.find("#email_input")

		describe 'check validity', ()->

			it 'should find email input invalid', () ->
				expect(email_input.hasClass('ng-valid')).toBe(false)
				angular.element(email_input).val('sometext').trigger('input')
				scope.$apply()
				expect(email_input.hasClass('ng-valid')).toBe(false)

			it 'should find email input valid', () ->
				expect(email_input.hasClass('ng-valid')).toBe(false)
				angular.element(email_input).val('sometext@gmail.com').trigger('input')
				scope.$apply()
				expect(email_input.hasClass('ng-valid')).toBe(true)

			it 'should find user_email exists', () ->
				expect(email_input.hasClass('ng-valid')).toBe(false)
				angular.element(email_input).val('l2silver@ryerson.ca').trigger('input')
				scope.$apply()
				httpBackend.flush()
				expect(scope.user_email_exists).toBe(true)

			it 'should find user_email does not exists', () ->
				expect(email_input.hasClass('ng-valid')).toBe(false)
				angular.element(email_input).val('l1silver@ryerson.ca').trigger('input')
				scope.$apply()
				httpBackend.flush()
				expect(scope.user_email_exists).toBe(false)

		describe 'check error message', ()->

			it 'should display email error message email required', () ->
				email_required_error_message = view.find("#email_required_error_message")
				expect(email_required_error_message.hasClass('ng-hide')).toBe(false)

			it 'should not display email error message email required', () ->
				email_required_error_message = view.find("#email_required_error_message")
				angular.element(email_input).val('sometext').trigger('input')
				scope.$apply()
				expect(email_required_error_message.hasClass('ng-hide')).toBe(true)

			it 'should display email error message email format', () ->
				email_format_error_message = view.find("#email_format_error_message")
				angular.element(email_input).val('sometext').trigger('input')
				scope.$apply()
				expect(email_format_error_message.hasClass('ng-hide')).toBe(false)	
			
			it 'should not display email error message email format', () ->
				email_format_error_message = view.find("#email_format_error_message")
				angular.element(email_input).val('sometext@gmail.com').trigger('input')
				scope.$apply()
				expect(email_format_error_message.hasClass('ng-hide')).toBe(true)

			it 'should display email error message email exists', () ->
				email_exists_error_message = view.find("#email_exists_error_message")
				angular.element(email_input).val('l2silver@ryerson.ca').trigger('input')
				scope.$apply()
				httpBackend.flush()
				expect(email_exists_error_message.hasClass('ng-hide')).toBe(false)
			
			it 'should not display email error message email format', () ->
				email_exists_error_message = view.find("#email_exists_error_message")
				angular.element(email_input).val('l1silver@ryerson.ca').trigger('input')
				scope.$apply()
				httpBackend.flush()
				expect(email_exists_error_message.hasClass('ng-hide')).toBe(true) 
		
	
	describe 'password input', ()->
		beforeEach ()->
			password_input = view.find("#password_input")

		describe 'check error message', ()->

			it 'should display error message password required', () ->
				password_required_error_message = view.find("#password_required_error_message")
				expect(password_required_error_message.hasClass('ng-hide')).toBe(false)

			it 'should not display error message password required', () ->
				password_required_error_message = view.find("#password_required_error_message")
				angular.element(password_input).val('sometext').trigger('input')
				scope.$apply()
				expect(password_required_error_message.hasClass('ng-hide')).toBe(true)

			it 'should display error message password minlength', () ->
				error_message = view.find("#password_minlength_error_message")
				angular.element(password_input).val('some').trigger('input')
				scope.$apply()
				expect(error_message.hasClass('ng-hide')).toBe(false)

			it 'should not display error message password required', () ->
				error_message = view.find("#password_minlength_error_message")
				angular.element(password_input).val('sometime').trigger('input')
				scope.$apply()
				expect(error_message.hasClass('ng-hide')).toBe(true)

		describe 'check validity', ()->

			it 'should find password input invalid', () ->
				expect(password_input.hasClass('ng-valid')).toBe(false)
				angular.element(password_input).val('some').trigger('input')
				scope.$apply()
				expect(password_input.hasClass('ng-valid')).toBe(false)

			it 'should find password input valid', () ->
				expect(password_input.hasClass('ng-valid')).toBe(false)
				angular.element(password_input).val('sometext').trigger('input')
				scope.$apply()
				expect(password_input.hasClass('ng-valid')).toBe(true)


			