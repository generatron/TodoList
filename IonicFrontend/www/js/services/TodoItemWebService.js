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
Filename:     TodoItemWebService.js
Description:  Angular service to access webservices endpoints
Project:      TodoList
Template: /ionic-1.7.14/services/webservice.vm
 */


'use strict';

/**
 * @ngdoc service
 * @name TodoListApp.webservice
 * @description
 * # webservice
 * Service in the TodoListApp.
 */

//Set the url to the backend service here
angular.module('TodoList.services')
    .service('TodoItemWS', function($http) {

        var todoItems = [];
        var todoItem = {};
        return {
            /*
             * TodoItem Methods 
             * 
             */
            getTodoItems: function() {
                return todoItems;
            },
            setTodoItems: function(data) {
                todoItems = data;
            },
            //Should be a blueprint endpoint
            retrieve: function(cb, cberror, id) {
                var url = config.baseurl + "todoItem/" + id;
                console.log(url);
                $http.get(url).success(cb).error(cberror);

            },
            list: function(cb, cberror) {
                var url = config.baseurl + "todoItem";
                console.log(url);
                $http.get(url).success(cb).error(cberror);
            }

            ,
            create: function(cb, cberror, params) {
                var url = config.baseurl + "todoItem";
                $http.post(url, params).success(cb).error(cberror);
            },
            update: function(cb, cberror, params) {
                var id = 0
                if (BACKEND == GRAILSBACKEND) {
                    params.id = params.id;
                }
                var url = config.baseurl + "todoItem/" + params.id;
                $http.put(url, params).success(cb).error(cberror);
            },
            delete: function(cb, cberror, params) {
                if (BACKEND == GRAILSBACKEND) {
                    params.id = params.id;
                }
                var url = config.baseurl + "todoItem/" + params.id;
                $http.delete(url, params).success(cb).error(cberror);
            }


            //Now on to the declared routes

        } // closes return 
    });

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 18.74 minutes to type the 1874+ characters in this file.
 */