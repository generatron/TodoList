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
Filename:     status.service.js
Description:  Packaging Information
Project:      TodoList
Template: ionic/service.js.vm
 */

/**
 * Status Service
 */
var baseurl = "http://localhost:9000/TodoList/api/";
angular.module('TodoList.status.services', ['ionic'])
    .factory('StatusService', function($http) {
        var statuss = [];
        var status = {};
        return {

            findAll: function() {
                var url = baseurl + "listStatus";
                return $http.get(url);
            },

            findById: function(id) {
                var url = baseurl + "getStatus?id=" + id;
                return $http.get(url);
            },

            getStatuss: function() {
                return statuss;
            },
            setStatuss: function(new_statuss) {
                statuss = new_statuss;
            },

            getStatus: function() {
                return status;
            },
            setStatus: function(new_status) {
                status = new_status;
            },
            save: function(entity) {
                return $http({
                    url: baseurl + 'addStatus',
                    method: "POST",
                    data: entity,
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })



            },

            update: function(entity) {},

            delete: function(id) {
                var url = baseurl + "deleteStatus?id=" + id;
                return $http.get(url);
            }

        }
    });




/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 12.55 minutes to type the 1255+ characters in this file.
 */