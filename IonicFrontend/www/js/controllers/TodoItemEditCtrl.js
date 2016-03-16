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
Filename:     TodoItemEditCtrl.js
Description:  Creates a controller to edit a record, loads foreign key tables to feed dropdowns
Project:      TodoList
Template: /ionic-1.7.14/controllers/edit.controller.js.vm
 */


'use strict';

/**
 * @ngdoc function
 * @name TodoList.controller:TodoItemsCtrl
 * @description
 * # TodoItemsCtrl
 * 
 */
angular.module('TodoList.controllers')
    .controller('TodoItemEditCtrl', function($scope, $stateParams, $rootScope, TodoItemWS) {
        $scope.todoItem = {};




        $scope.edit = true;
        $scope.save = function() {
            var data = {};
            data = $scope.todoItem;
            TodoItemWS.update($scope.updatesuccesscb, $scope.errorcb, data);
        }

        $scope.delete = function() {
            var data = {};
            if (BACKEND == GRAILSBACKEND) {
                data.model = $scope.todoItem;
            } else {
                data = $scope.todoItem;
            }
            TodoItemWS.delete($scope.updatesuccesscb, $scope.errorcb, data);
        }
        $scope.cancel = function() {
            document.location.href = "#/todoItems"
        }

        $scope.updatesuccesscb = function(data, status, headers, config) {
            document.location.href = "#/todoItems"
        }
        $scope.successcb = function(data, status, headers, config) {
            $scope.todoItem = data;

        }

        $scope.errorcb = function(data, status, headers, config) {

            alert("Failed: " + JSON.stringify(data));
        }
        $scope.loadReferences = function() {

            // false Bool String completed
            // false Integer String id
            // false Integer String order
            // false String String title
            // false String String url

        }
        $scope.loadReferences();
        TodoItemWS.retrieve($scope.successcb, $scope.errorcb, $stateParams.id);
    }).config(function($stateProvider) {
        $stateProvider
            .state('app.editTodoItem', {
                url: '/todoItem/:id',
                views: {
                    'menuContent': {
                        templateUrl: 'templates/todoItem.html',
                        controller: 'TodoItemEditCtrl'
                    }
                }
            })
    });

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 19.36 minutes to type the 1936+ characters in this file.
 */