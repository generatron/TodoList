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


// Example using templating of strings
#if os(OSX) // Mustache implented for OSX only yet
Router.sharedInstance.get("/") { _, response, next in
    defer {
        next()
    }
    do {

        let template = try Template(string: "Hello {{name}}\n" +
            "Your beard trimmer will arrive on {{format(date)}}.\n" +
            "{{#late}}" +
            "Well, on {{format(realDate)}} because of a Martian attack." +
            "{{/late}}")
        // Let template format dates with `{{format(...)}}`
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        template.registerInBaseContext("format", Box(dateFormatter))

        // The rendered data
        let data = [
            "name": "Arthur",
            "date": NSDate(),
            "realDate": NSDate().dateByAddingTimeInterval(60*60*24*3),
            "late": true
        ]
        var rendering = ""
        
        do {
            rendering = try template.render(Box(data))
        }
        catch {
            Log.error("Failed to render mustache template")
        }

        do {
            try response.status(HttpStatusCode.OK).end(rendering)
        }
        catch {
            Log.error("Failed to send response")
        }
    }
    catch {
        Log.error("Failed to create mustache template")
    }
}
#endif


// Listen on port 9000
let server = HttpServer.listen(Config.sharedInstance.port,delegate: Router.sharedInstance)

Server.run()

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 17.33 minutes to type the 1733+ characters in this file.
 */


