controllers = angular.module('controllers')

controllers.controller "LoggedInController", ['$scope', 'globalJobPost', ($scope, globalJobPost) ->
	$scope.setauthenticityToken = (key)->
		globalJobPost.publishData("authenticityToken", key)
]