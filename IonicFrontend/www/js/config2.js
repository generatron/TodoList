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
Filename:     config2.js
Description:  Endpoint configuration for the app
Project:      TodoList
Template: ionic-1.7.14/config.js.vmg
 */
var GRAILSBACKEND = 0
var SAILSBACKEND = 1
var PERFECTBACKEND = 2
var BACKEND = GRAILSBACKEND
var config = {}

if (BACKEND == SAILSBACKEND) {
    config = {
        baseurl: "http://localhost:1337/"
    };
}
if (BACKEND == GRAILSBACKEND) {
    config = {
        baseurl: "http://localhost:9000/api/"
    };
}
if (BACKEND == PERFECTBACKEND) {
    config = {
        baseurl: "http://localhost:8181/api/"
    };
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 3.6 minutes to type the 360+ characters in this file.
 */