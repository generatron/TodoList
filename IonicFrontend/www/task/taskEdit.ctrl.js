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
Filename:     taskEdit.ctrl.js
Description:  Packaging Information
Project:      TodoList
Template: ionic/edit.controller.js.vm
 */


angular.module('TodoList.task.controllers')
    .controller('TaskEditCtrl', function($scope, $window, TaskService, $ionicModal, $stateParams, TodoItemService) {
        console.log("TaskEditCtrl");

        $scope.task = TaskService.getTask();

        $scope.loadTaskCombos = function() {
            //Gets data to fill combo for  ${domain.type} values;
            TodoItemService.findAll().success(function(todoItems) {
                $scope.todoItems = todoItems
            });
        };


        // Update Task: gets values and saves via Webservice 
        $scope.updateTask = function(task) {

            $scope.task = {};

            $scope.task['description'] = task.description;
            $scope.task['id'] = task.id;
            $scope.task['title'] = task.title;
            if (typeof task.todo != 'undefined') {
                $scope.task['todo'] = task.todo.id;
            } else {
                $scope.task['todo'] = null;
            }



            //sends request
            TaskService.save($scope.task).success(function(data, status, headers, config) {
                //refresh list
                //resets values
                //$scope.hideEditTaskModal();
                $window.history.back();
                TaskService.findAll().success(function(tasks) {
                    $scope.tasks = tasks
                });

            }).error(function(data, status, headers, config) {
                $scope.status = status;
                alert(data);
            });
        };

        // Delete Task: gets values and saves via Webservice 
        $scope.deleteTask = function(task) {
            //sends request
            TaskService.delete(task.id).success(function(data, status, headers, config) {
                //refresh list
                //$scope.hideEditTaskModal();
                $window.history.back();
                TaskService.findAll().success(function(tasks) {
                    $scope.tasks = tasks
                });

            }).error(function(data, status, headers, config) {
                //$scope.status = status;
                alert(data);
            });

        };

        $scope.loadTaskCombos();

    });


/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 15.9 minutes to type the 1590+ characters in this file.
 */