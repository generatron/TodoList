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
Filename:     taskList.ctrl.js
Description:  Packaging Information
Project:      TodoList
Template: ionic/list.controller.js.vm
 */


angular.module('TodoList.task.controllers', ['ionic'])
    .controller('TasksCtrl', function($scope, $location, TaskService, $ionicModal, TodoItemService) {
        console.log("TasksCtrl");
        //Filtering function
        $scope.filterTask = function(query) {
            return function(item) {
                if (query == undefined) {
                    return true;
                }
                var include = false;
                return include;
            };
        };

        $scope.editTask = function(task) {
            TaskService.setTask(task);
            $location.path('/app/task');
        }

        $scope.loadTaskCombos = function() {
            //Gets data to fill combo for  ${domain.type} values;
            TodoItemService.findAll().success(function(todoItems) {
                $scope.todoItems = todoItems
            });
        }

        // Create and load the Modal
        $ionicModal.fromTemplateUrl('task/templates/new-task.html', function(modal) {
            $scope.taskCreateModal = modal;
        }, {
            scope: $scope,
            animation: 'slide-in-up'
        });

        ///$scope.loadTaskCombos();

        // Open our new task modal
        $scope.showCreateTaskModal = function() {
            $scope.taskCreateModal.show();
        };

        // Close the new task modal
        $scope.hideCreateTaskModal = function() {
            $scope.taskCreateModal.hide();
        };


        // New Task: gets values and saves via Webservice 
        $scope.createTask = function(task) {
            $scope.task = {};

            $scope.task['description'] = task.description;
            $scope.task['id'] = task.id;
            $scope.task['title'] = task.title;
            if (typeof task.todo != 'undefined') {
                $scope.task['todo'] = task.todo.id;
            } else {
                $scope.task['todo'] = null;
            }

            $scope.hideCreateTaskModal();
            //sends request
            TaskService.save($scope.task).success(function(data, status, headers, config) {

                //resets values
                //refresh list
                TaskService.findAll().success(function(tasks) {
                    $scope.tasks = tasks
                });


            }).error(function(data, status, headers, config) {
                //$scope.status = status;
                alert(data);
            });



        };

        // Create and load the Modal
        $ionicModal.fromTemplateUrl('task/templates/edit-task.html', function(modal) {
            $scope.taskEditModal = modal;
        }, {
            scope: $scope,
            animation: 'slide-in-up'
        });

        // Open our new task modal
        $scope.showEditTaskModal = function(task) {
            $scope.task = task;
            $scope.taskEditModal.show();
        };

        // Close the new task's modal
        $scope.hideEditTaskModal = function() {
            $scope.taskEditModal.hide();
        };


        //if (TaskService.getTasks().length == 0) {
        // $scope.searchTask("");
        TaskService.findAll().success(function(tasks) {

            $scope.tasks = tasks
            TaskService.setTasks(tasks);
        });
        //} else {
        //    $scope.task = TaskService.getTasks();
        //}

    })

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 25.64 minutes to type the 2564+ characters in this file.
 */