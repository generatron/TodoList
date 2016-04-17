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
Filename:     todoItemList.ctrl.js
Description:  Packaging Information
Project:      TodoList
Template: ionic/list.controller.js.vm
 */


angular.module('TodoList.todoItem.controllers', ['ionic'])
    .controller('TodoItemsCtrl', function($scope, $location, TodoItemService, $ionicModal, StatusService) {
        console.log("TodoItemsCtrl");
        //Filtering function
        $scope.filterTodoItem = function(query) {
            return function(item) {
                if (query == undefined) {
                    return true;
                }
                var include = false;
                return include;
            };
        };

        $scope.editTodoItem = function(todoItem) {
            TodoItemService.setTodoItem(todoItem);
            $location.path('/app/todoItem');
        }

        $scope.loadTodoItemCombos = function() {
            //Gets data to fill combo for  ${domain.type} values;
            StatusService.findAll().success(function(statuss) {
                $scope.statuss = statuss
            });
        }

        // Create and load the Modal
        $ionicModal.fromTemplateUrl('todoItem/templates/new-todoItem.html', function(modal) {
            $scope.todoItemCreateModal = modal;
        }, {
            scope: $scope,
            animation: 'slide-in-up'
        });

        ///$scope.loadTodoItemCombos();

        // Open our new todoItem modal
        $scope.showCreateTodoItemModal = function() {
            $scope.todoItemCreateModal.show();
        };

        // Close the new todoItem modal
        $scope.hideCreateTodoItemModal = function() {
            $scope.todoItemCreateModal.hide();
        };


        // New TodoItem: gets values and saves via Webservice 
        $scope.createTodoItem = function(todoItem) {
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

            $scope.hideCreateTodoItemModal();
            //sends request
            TodoItemService.save($scope.todoItem).success(function(data, status, headers, config) {

                //resets values
                //refresh list
                TodoItemService.findAll().success(function(todoItems) {
                    $scope.todoItems = todoItems
                });


            }).error(function(data, status, headers, config) {
                //$scope.status = status;
                alert(data);
            });



        };

        // Create and load the Modal
        $ionicModal.fromTemplateUrl('todoItem/templates/edit-todoItem.html', function(modal) {
            $scope.todoItemEditModal = modal;
        }, {
            scope: $scope,
            animation: 'slide-in-up'
        });

        // Open our new todoItem modal
        $scope.showEditTodoItemModal = function(todoItem) {
            $scope.todoItem = todoItem;
            $scope.todoItemEditModal.show();
        };

        // Close the new todoItem's modal
        $scope.hideEditTodoItemModal = function() {
            $scope.todoItemEditModal.hide();
        };


        //if (TodoItemService.getTodoItems().length == 0) {
        // $scope.searchTodoItem("");
        TodoItemService.findAll().success(function(todoItems) {

            $scope.todoItems = todoItems
            TodoItemService.setTodoItems(todoItems);
        });
        //} else {
        //    $scope.todoItem = TodoItemService.getTodoItems();
        //}

    })

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 30.020002 minutes to type the 3002+ characters in this file.
 */