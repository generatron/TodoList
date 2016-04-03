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
Filename:     StatussCtrl.js
Description:  This is the controller to load the grid with data, will inject and use webservice, will also add route for this controller to the routing handler
Project:      TodoList
Template: /ionic-1.7.14/controllers/grid.controller.vm
 */


'use strict';

/**
 * @ngdoc function
 * @name TodoList.controller:StatussCtrl
 * @description
 * # StatussCtrl
 * 
 */
angular.module('TodoList.controllers')
    .controller('StatussCtrl', function($scope, $rootScope, $timeout, $ionicFilterBar, StatusWS) {

        var filterBarInstance;

        $scope.showFilterBar = function() {
            filterBarInstance = $ionicFilterBar.show({
                items: $scope.statuss,
                update: function(filteredItems) {
                    $scope.statuss = filteredItems;
                },
                //filterProperties: []
            });
        };
        /*
        these properties are shown in the cell
          */

        $scope.refreshItems = function() {
            if (filterBarInstance) {
                filterBarInstance();
                filterBarInstance = null;
            }
            StatusWS.list($scope.successcb, $scope.errorcb);
        };

        $scope.addStatus = function() {
            document.location.href = "#/app/status"
        }

        $scope.successcb = function(data, status, headers, config) {
            $scope.statuss = data;
            $scope.$broadcast('scroll.refreshComplete');
        }

        $scope.errorcb = function(data, status, headers, config) {
            alert("Failed: " + JSON.stringify(data));
        }

        $scope.selected = function(status) {
            $scope.status = status;
            document.location.href = "#/status/" + status.id
        }
        StatusWS.list($scope.successcb, $scope.errorcb);
    }).config(function($stateProvider) {
        $stateProvider
            .state('app.statuss', {
                url: "/statuss",
                views: {
                    'menuContent': {
                        templateUrl: "templates/statuss.html",
                        controller: 'StatussCtrl'
                    }
                }
            })
    });

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 17.07 minutes to type the 1707+ characters in this file.
 */