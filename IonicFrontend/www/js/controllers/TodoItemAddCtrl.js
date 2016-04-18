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
Filename:     TodoItemAddCtrl.js
Description:  Controller to create a new record, loads foreign keys
Project:      TodoList
Template: /ionic-1.7.14/controllers/add.controller.vm
 */


'use strict';

/**
 * @ngdoc function
 * @name TodoList.controller:TodoItemAddCtrl
 * @description
 * # TodoItemAddCtrl
 * Controller of the TodoList
 */
angular.module('TodoList.controllers')
    .controller('TodoItemAddCtrl', function($scope, StatusWS, TodoItemWS, TaskWS) {

        var dueDateDatePickerCallBack = function(val) {
            if (typeof(val) === 'undefined') {
                console.log('No date selected');
            } else {
                console.log('Selected date is : ', val)
            }
        };

        $scope.dueDateDatePicker = {
            titleLabel: 'DueDate', //Optional
            todayLabel: 'Today', //Optional
            closeLabel: 'Close', //Optional
            setLabel: 'Set', //Optional
            setButtonType: 'button-assertive', //Optional
            todayButtonType: 'button-assertive', //Optional
            closeButtonType: 'button-assertive', //Optional
            inputDate: new Date(), //Optional
            mondayFirst: true, //Optional
            templateType: 'popup', //Optional
            showTodayButton: 'true', //Optional
            modalHeaderColor: 'bar-positive', //Optional
            modalFooterColor: 'bar-positive', //Optional
            callback: function(val) { //Mandatory
                dueDateDatePickerCallBack(val);
            }
        };

        $scope.todoItem = {};
        $scope.todoItem.status = {}
        $scope.edit = false;
        $scope.successcb = function(data, status, headers, config) {
            document.location.href = "#/app/todoItems"
        }

        $scope.errorcb = function(data, status, headers, config) {
            //alert("Failed: "+JSON.stringify(data));
            for (var e in data.errors) {
                var error = data.errors[e];
                $("#" + error.field + "Error").html(error.message);
            }
        }

        $scope.save = function() {
            var data = {};
            data = $scope.todoItem;
            TodoItemWS.create($scope.successcb, $scope.errorcb, data);
        }

        $scope.cancel = function() {
            document.location.href = "#/todoItems"
        }

        $scope.loadReferences = function() {
            StatusWS.list(function(data) {
                $scope.statuss = data;
            }, $scope.errorcb)
            TaskWS.list(function(data) {
                $scope.taskss = data;
            }, $scope.errorcb)

        }
        $scope.loadReferences();


    }).config(function($stateProvider) {
        $stateProvider
            .state('app.addTodoItem', {
                url: '/todoItem',
                views: {
                    'menuContent': {
                        templateUrl: 'templates/todoItem.html',
                        controller: 'TodoItemAddCtrl'
                    }
                }
            })

    });

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 27.09 minutes to type the 2709+ characters in this file.
 */