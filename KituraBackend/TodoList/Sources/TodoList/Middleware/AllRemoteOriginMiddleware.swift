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
Filename:     AllRemoteOriginMiddleware.swift
Description:  Swift Server
Project:      TodoList
Template: /Kitura/server/AllRemoteOriginMiddleware.swift.vmg
 */
import KituraRouter
import KituraNet

import LoggerAPI
import SwiftyJSON

/// Custom middleware that allows Cross Origin HTTP requests	
class AllRemoteOriginMiddleware: RouterMiddleware {
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        Log.info("Added cross origin header")
        response.status(200);
        response.setHeader("Access-Control-Allow-Origin", value: "*")
        response.setHeader("Access-Control-Allow-Headers", value: "Origin, X-Requested-With, Content-Type, Accept")
        response.setHeader("Access-Control-Allow-Methods", value: "DELETE,POST,PUT,GET,OPTIONS,HEAD")
        next()
    }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 6.76 minutes to type the 676+ characters in this file.
 */
