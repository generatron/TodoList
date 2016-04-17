/* 
Copyright (c) 2016 NgeosOne LLC
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

   
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

Engineered using http://www.generatron.com/

[GENERATRON]
Generator :   System Templates
Filename:     app.js
Description:  Packaging Information
Project:      TodoList
Template: ionic/app.js.vmg
 */

// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.services' is found in services.js
// 'starter.controllers' is found in controllers.js


//

var app = angular.module('TodoList', ['ionic', 'TodoList.controllers',
    'TodoList.status',
    'TodoList.task',
    'TodoList.todoItem'
])

.run(function($ionicPlatform, $window) {
    $ionicPlatform.ready(function() {
        if ($window.StatusBar) {
            StatusBar.styleDefault();
        }
    });
})

.config(function($stateProvider, $urlRouterProvider, $httpProvider) {

    $stateProvider
        .state('app', {
            url: "/app",
            abstract: true,
            templateUrl: 'templates/menu.html'
        })

    .state('app.dash', {
        url: '/dash',
        views: {
            'menuContent': {
                templateUrl: 'templates/app-dash.html',
                controller: 'DashCtrl'
            }
        }
    })

    .state('app.statuss', {
        url: '/statuss',
        views: {
            'menuContent': {
                templateUrl: 'status/templates/statuss.html',
                controller: 'StatussCtrl'
            }
        }
    })

    .state('app.status', {
        url: '/status',
        views: {
            'menuContent': {
                templateUrl: 'status/templates/edit-status.html',
                controller: 'StatusEditCtrl'
            }
        }
    })

    .state('app.tasks', {
        url: '/tasks',
        views: {
            'menuContent': {
                templateUrl: 'task/templates/tasks.html',
                controller: 'TasksCtrl'
            }
        }
    })

    .state('app.task', {
        url: '/task',
        views: {
            'menuContent': {
                templateUrl: 'task/templates/edit-task.html',
                controller: 'TaskEditCtrl'
            }
        }
    })

    .state('app.todoItems', {
        url: '/todoItems',
        views: {
            'menuContent': {
                templateUrl: 'todoItem/templates/todoItems.html',
                controller: 'TodoItemsCtrl'
            }
        }
    })

    .state('app.todoItem', {
        url: '/todoItem',
        views: {
            'menuContent': {
                templateUrl: 'todoItem/templates/edit-todoItem.html',
                controller: 'TodoItemEditCtrl'
            }
        }
    })

    // default state
    $urlRouterProvider.otherwise('/app/dash');

})

// check auth data
//.run(function ($ionicPlatform, auth) {
.run(function($ionicPlatform) {
        $ionicPlatform.ready(function() {})
    })
    // configuration
;


/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 26.44 minutes to type the 2644+ characters in this file.
 */