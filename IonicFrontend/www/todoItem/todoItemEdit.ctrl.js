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
Filename:     todoItemEdit.ctrl.js
Description:  Packaging Information
Project:      TodoList
Template: ionic/edit.controller.js.vm
 */


angular.module('TodoList.todoItem.controllers')
    .controller('TodoItemEditCtrl', function($scope, $window, TodoItemService, $ionicModal, $stateParams, StatusService) {
        console.log("TodoItemEditCtrl");

        $scope.todoItem = TodoItemService.getTodoItem();

        $scope.loadTodoItemCombos = function() {
            //Gets data to fill combo for  ${domain.type} values;
            StatusService.findAll().success(function(statuss) {
                $scope.statuss = statuss
            });
        };


        // Update TodoItem: gets values and saves via Webservice 
        $scope.updateTodoItem = function(todoItem) {

            $scope.todoItem = {};

            $scope.todoItem['completed'] = todoItem.completed;
            $scope.todoItem['dueDate'] = todoItem.dueDate;
            $scope.todoItem['id'] = todoItem.id;
            $scope.todoItem['order'] = todoItem.order;
            if (typeof todoItem.status != 'undefined') {
                $scope.todoItem['status'] = todoItem.status.id;
            } else {
                $scope.todoItem['status'] = null;
            }
            $scope.todoItem['tasks'] = todoItem.tasks;
            $scope.todoItem['title'] = todoItem.title;
            $scope.todoItem['url'] = todoItem.url;



            //sends request
            TodoItemService.save($scope.todoItem).success(function(data, status, headers, config) {
                //refresh list
                //resets values
                //$scope.hideEditTodoItemModal();
                $window.history.back();
                TodoItemService.findAll().success(function(todoItems) {
                    $scope.todoItems = todoItems
                });

            }).error(function(data, status, headers, config) {
                $scope.status = status;
                alert(data);
            });
        };

        // Delete TodoItem: gets values and saves via Webservice 
        $scope.deleteTodoItem = function(todoItem) {
            //sends request
            TodoItemService.delete(todoItem.id).success(function(data, status, headers, config) {
                //refresh list
                //$scope.hideEditTodoItemModal();
                $window.history.back();
                TodoItemService.findAll().success(function(todoItems) {
                    $scope.todoItems = todoItems
                });

            }).error(function(data, status, headers, config) {
                //$scope.status = status;
                alert(data);
            });

        };

        $scope.loadTodoItemCombos();

    });


/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 19.16 minutes to type the 1916+ characters in this file.
 */