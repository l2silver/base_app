controllers = angular.module('controllers')

controllers.controller "LoggedOutController", ['$scope', '$resource', ($scope, $resource) ->
	$scope.menu_names = ["Section_1", "Section_2"]
	$scope.goTo = (menu_id) ->
		target = $("#" + menu_id)
		$('html,body').animate({
			scrollTop: target.offset().top - 50
			}, 500)
		return false
]