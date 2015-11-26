controllers = angular.module('controllers')

controllers.controller "SignupController", ['$scope', '$resource', ($scope, $resource) ->
	EmailResponse = $resource('/users/check_email/')
	
	$scope.user_email_exists = true
	$scope.user = null
	$scope.submit_signup = (event, invalid)->
		if $scope.user_email_exists || invalid
			event.preventDefault()
	$scope.check_email = (email) ->
			if(email)
				users = EmailResponse.get({email: email},() ->
					$scope.hello3 = email
					$scope.user = users
					$scope.user_response == $scope.user
					if $scope.user.response == true
						$scope.user_email_exists = true
					else
						$scope.user_email_exists = false
				)
]