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
Filename:     TodoItemController.swift
Description:  TodoItem Handlers for REST endpoints 
Project:      TodoList
Template: /Kitura/server/EntityRouterClass.swift.vm
 */

import KituraRouter
import KituraNet
import KituraSys

import HeliumLogger
import LoggerAPI

import Foundation

class TodoItemController  {
	var pm : PersistenceManager!
	 
	init(persistenceManager : PersistenceManager){
	self.pm = persistenceManager;
	 TodoListRouter.sharedInstance.get("/api/todoItem"){ request, response, next in
	    do{
	        let todoItems : [TodoItem]  = try self.pm.todoItemRepository.list()
	        let json = try TodoItem.encodeList(todoItems);
	        response.status(HttpStatusCode.OK).sendJson(json)
	  	}catch{
	  	    try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end();
	  	}
	    next()
	  }
	
	
	  TodoListRouter.sharedInstance.post("/api/todoItem"){ request, response, next in
	     let todoItem = TodoItem() 
	     do {
	     	if let body = request.body {
            	if let json = body.asJson() {
	                try todoItem.deserialize(json);
		    		let result = try self.pm.todoItemRepository.insert(todoItem)
		    		let json = try todoItem.encode()
		    		response.status(HttpStatusCode.OK).sendJson(json)
            	}
	        } else {
	            response.status(HttpStatusCode.BAD_REQUEST)
	        }
	    }catch{
	        try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end();
	    }
	    next()
	 }
	
	 TodoListRouter.sharedInstance.get("/api/todoItem/:id"){ request, response, next in
	   let id = Int(request.params["id"]!)
	    do{
	        let todoItem : TodoItem  = try self.pm.todoItemRepository.retrieve(id!)!
	        let json = try todoItem.encode()
	        response.status(HttpStatusCode.OK).sendJson(json)
	    }catch{
	        try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end();
	    }
	    next()
	 }
	
	 TodoListRouter.sharedInstance.put("/api/todoItem"){ request, response, next in
	    do {
	     	if let body = request.body {
            	if let json = body.asJson() {
            		let todoItem = TodoItem()
	                try todoItem.deserialize(json);
		    		let result = try self.pm.todoItemRepository.update(todoItem)
		    		let json = try todoItem.encode()
		    		response.status(HttpStatusCode.OK).sendJson(json)
            	}
	        } else {
	            response.status(HttpStatusCode.BAD_REQUEST)
	        }
	    }catch{
	        try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end();
	    }
	    next()
	 }

	 TodoListRouter.sharedInstance.delete("/api/todoItem/:id"){ request, response, next in
	    let id = Int(request.params["id"]!)
	    do{
	        let todoItem = try self.pm.todoItemRepository.delete(id!)
	        //response.status(HttpStatusCode.OK).sendJson(json)
	        response.status(HttpStatusCode.OK).end()
	    }catch{
	        try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end()
	    }
	    next()
	 }
  }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 28.74 minutes to type the 2874+ characters in this file.
 */
