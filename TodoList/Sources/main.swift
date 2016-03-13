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
Filename:     main.swift
Description:  Swift Server
Project:      TodoList
Template: /Kitura/server/main.swift.vmg
 */
import KituraSys
import KituraNet
import KituraRouter

import LoggerAPI
import HeliumLogger

#if os(Linux)
    import Glibc
#endif

import Foundation

#if os(OSX)
    import Mustache
#endif



//let persistenceManager = PersistenceManagerMySQL();
//let persistenceManager = PersistenceManagerSQLite();
let persistenceManager = PersistenceManagerMemory();

#if os(OSX) // Mustache implemented for OSX only yet

#endif

let server = HttpServer.listen(Config.sharedInstance.port,delegate: Router.sharedInstance)

Server.run()
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 5.51 minutes to type the 551+ characters in this file.
 */
