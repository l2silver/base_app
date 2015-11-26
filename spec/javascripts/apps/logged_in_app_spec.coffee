fixture.preload("users.json")

describe 'LoggedInApp', ()->
	

	globalJobPost = null
	scope = null

	beforeEach module('LoggedInApp')

	setupController = ()->
		inject (_globalJobPost_, $rootScope)->
			globalJobPost = _globalJobPost_
			scope = $rootScope.$new()


	beforeEach setupController()

	describe "global job post service", ()->

		it "should set global listener", ()->
			globalJobPost.addSubscriber(scope, ['formValidation'])
			globalJobPost.publishData('formValidation', "test")
			expect(scope.formValidation).toBe("test")

		it "should set local attribute", ()->
			globalJobPost.addSubscriber(scope, ['formValidation'])
			globalJobPost.publishData('formValidation', "test")
			expect(globalJobPost.formValidation).toBe("test")

		it "should set 'on' scope attribute if called after publish", ()->
			globalJobPost.publishData('formValidation', "test")
			globalJobPost.addSubscriber(scope, ['formValidation'])
			expect(scope.formValidation).toBe("test")