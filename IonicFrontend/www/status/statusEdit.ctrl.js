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
Filename:     statusEdit.ctrl.js
Description:  Packaging Information
Project:      TodoList
Template: ionic/edit.controller.js.vm
 */


angular.module('TodoList.status.controllers')
    .controller('StatusEditCtrl', function($scope, $window, StatusService, $ionicModal, $stateParams) {
        console.log("StatusEditCtrl");

        $scope.status = StatusService.getStatus();

        $scope.loadStatusCombos = function() {};


        // Update Status: gets values and saves via Webservice 
        $scope.updateStatus = function(status) {

            $scope.status = {};

            $scope.status['id'] = status.id;
            $scope.status['name'] = status.name;



            //sends request
            StatusService.save($scope.status).success(function(data, status, headers, config) {
                //refresh list
                //resets values
                //$scope.hideEditStatusModal();
                $window.history.back();
                StatusService.findAll().success(function(statuss) {
                    $scope.statuss = statuss
                });

            }).error(function(data, status, headers, config) {
                $scope.status = status;
                alert(data);
            });
        };

        // Delete Status: gets values and saves via Webservice 
        $scope.deleteStatus = function(status) {
            //sends request
            StatusService.delete(status.id).success(function(data, status, headers, config) {
                //refresh list
                //$scope.hideEditStatusModal();
                $window.history.back();
                StatusService.findAll().success(function(statuss) {
                    $scope.statuss = statuss
                });

            }).error(function(data, status, headers, config) {
                //$scope.status = status;
                alert(data);
            });

        };

        $scope.loadStatusCombos();

    });


/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 13.37 minutes to type the 1337+ characters in this file.
 */