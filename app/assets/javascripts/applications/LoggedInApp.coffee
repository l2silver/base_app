app = angular.module('LoggedInApp', ['ng','templates', 'controllers', 'ngResource', "ngRoute"])
angular.module('controllers', [])

app.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/job_posts/:job_post_id',
        templateUrl: "job_post/job_post.html"
        controller: 'JobPostController'
      )
      .otherwise('job_posts/:job_post_id',
        templateURL: "job_post/job_post.html"
        controller: "JobPostController"
      )
])

app.service 'globalJobPost', [ '$rootScope' , ($rootScope)->
  globalJobPost =  {
    publishData: (name, data)->
      $rootScope.$broadcast(name, data)
      this[name] = data

    addSubscriber: ($scope, $name_array)->
      angular.forEach($name_array, (name, index)->
        $scope.$on name, (event, data)->
          $scope[name] = data
        if globalJobPost[name] != undefined
          $scope[name] = globalJobPost[name]
      )
  }

  return globalJobPost
]