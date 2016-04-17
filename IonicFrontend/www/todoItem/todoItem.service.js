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
Filename:     todoItem.service.js
Description:  Packaging Information
Project:      TodoList
Template: ionic/service.js.vm
 */

/**
 * TodoItem Service
 */
var baseurl = "http://localhost:9000/TodoList/api/";
angular.module('TodoList.todoItem.services', ['ionic'])
    .factory('TodoItemService', function($http) {
        var todoItems = [];
        var todoItem = {};
        return {

            findAll: function() {
                var url = baseurl + "listTodoItem";
                return $http.get(url);
            },

            findById: function(id) {
                var url = baseurl + "getTodoItem?id=" + id;
                return $http.get(url);
            },

            getTodoItems: function() {
                return todoItems;
            },
            setTodoItems: function(new_todoItems) {
                todoItems = new_todoItems;
            },

            getTodoItem: function() {
                return todoItem;
            },
            setTodoItem: function(new_todoItem) {
                todoItem = new_todoItem;
            },
            save: function(entity) {
                return $http({
                    url: baseurl + 'addTodoItem',
                    method: "POST",
                    data: entity,
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })



            },

            update: function(entity) {},

            delete: function(id) {
                var url = baseurl + "deleteTodoItem?id=" + id;
                return $http.get(url);
            }

        }
    });




/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 12.97 minutes to type the 1297+ characters in this file.
 */