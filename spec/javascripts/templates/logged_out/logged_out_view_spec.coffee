describe 'logged_out_view', ()->
	
	scope = null
	html = null
	ctrl = null
	compile = null
	view = null

	beforeEach module('LoggedOutApp')

	setupController = ()->
		inject(($controller, $rootScope, $templateCache, $compile, $httpBackend)->
			scope = $rootScope.$new()
			ctrl = $controller('LoggedOutController', $scope: scope)
			compile = $compile
			html = $templateCache.get 'landing_page/landing_page.html'
			view = $compile(angular.element(html))(scope)
			scope.$digest()
			)

	beforeEach setupController()