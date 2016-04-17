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
Filename:     statusList.ctrl.js
Description:  Packaging Information
Project:      TodoList
Template: ionic/list.controller.js.vm
 */


angular.module('TodoList.status.controllers', ['ionic'])
    .controller('StatussCtrl', function($scope, $location, StatusService, $ionicModal) {
        console.log("StatussCtrl");
        //Filtering function
        $scope.filterStatus = function(query) {
            return function(item) {
                if (query == undefined) {
                    return true;
                }
                var include = false;
                return include;
            };
        };

        $scope.editStatus = function(status) {
            StatusService.setStatus(status);
            $location.path('/app/status');
        }

        $scope.loadStatusCombos = function() {}

        // Create and load the Modal
        $ionicModal.fromTemplateUrl('status/templates/new-status.html', function(modal) {
            $scope.statusCreateModal = modal;
        }, {
            scope: $scope,
            animation: 'slide-in-up'
        });

        ///$scope.loadStatusCombos();

        // Open our new status modal
        $scope.showCreateStatusModal = function() {
            $scope.statusCreateModal.show();
        };

        // Close the new status modal
        $scope.hideCreateStatusModal = function() {
            $scope.statusCreateModal.hide();
        };


        // New Status: gets values and saves via Webservice 
        $scope.createStatus = function(status) {
            $scope.status = {};

            $scope.status['id'] = status.id;
            $scope.status['name'] = status.name;

            $scope.hideCreateStatusModal();
            //sends request
            StatusService.save($scope.status).success(function(data, status, headers, config) {

                //resets values
                //refresh list
                StatusService.findAll().success(function(statuss) {
                    $scope.statuss = statuss
                });


            }).error(function(data, status, headers, config) {
                //$scope.status = status;
                alert(data);
            });



        };

        // Create and load the Modal
        $ionicModal.fromTemplateUrl('status/templates/edit-status.html', function(modal) {
            $scope.statusEditModal = modal;
        }, {
            scope: $scope,
            animation: 'slide-in-up'
        });

        // Open our new status modal
        $scope.showEditStatusModal = function(status) {
            $scope.status = status;
            $scope.statusEditModal.show();
        };

        // Close the new status's modal
        $scope.hideEditStatusModal = function() {
            $scope.statusEditModal.hide();
        };


        //if (StatusService.getStatuss().length == 0) {
        // $scope.searchStatus("");
        StatusService.findAll().success(function(statuss) {

            $scope.statuss = statuss
            StatusService.setStatuss(statuss);
        });
        //} else {
        //    $scope.status = StatusService.getStatuss();
        //}

    })

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 23.67 minutes to type the 2367+ characters in this file.
 */