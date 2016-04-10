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
Filename:     TaskEditCtrl.js
Description:  Creates a controller to edit a record, loads foreign key tables to feed dropdowns
Project:      TodoList
Template: /ionic-1.7.14/controllers/edit.controller.js.vm
 */


'use strict';

/**
 * @ngdoc function
 * @name TodoList.controller:TasksCtrl
 * @description
 * # TasksCtrl
 * 
 */
angular.module('TodoList.controllers')
    .controller('TaskEditCtrl', function($scope, $stateParams, $rootScope, TodoItemWS, TaskWS) {
        $scope.task = {};




        $scope.edit = true;
        $scope.save = function() {
            TaskWS.update($scope.updatesuccesscb, $scope.errorcb, $scope.task);
        }

        $scope.delete = function() {
            var data = {};

            TaskWS.delete($scope.updatesuccesscb, $scope.errorcb, $scope.task);
        }
        $scope.cancel = function() {
            document.location.href = "#/app/tasks"
        }

        $scope.updatesuccesscb = function(data, status, headers, config) {
            document.location.href = "#/app/tasks"
        }
        $scope.successcb = function(data, status, headers, config) {
            $scope.task = data;

        }

        $scope.errorcb = function(data, status, headers, config) {

            alert("Failed: " + JSON.stringify(data));
        }
        $scope.loadReferences = function() {

            TodoItemWS.list(function(data) {
                $scope.todos = data;
            }, $scope.errorcb)

        }
        $scope.loadReferences();
        TaskWS.retrieve($scope.successcb, $scope.errorcb, $stateParams.id);
    }).config(function($stateProvider) {
        $stateProvider
            .state('app.editTask', {
                url: '/task/:id',
                views: {
                    'menuContent': {
                        templateUrl: 'templates/task.html',
                        controller: 'TaskEditCtrl'
                    }
                }
            })
    });

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 17.04 minutes to type the 1704+ characters in this file.
 */