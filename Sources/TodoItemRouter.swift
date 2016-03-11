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
Filename:     TodoItemRouter.swift
Description:  TodoItem Handlers for REST endpoints 
Project:      TodoList
Template: /Kitura/server/EntityRouterClass.swift.vm
 */


class TodoItemRouter  { 
	init(){
	 Router.sharedInstance.get("/api/todoItem"){ request, response, next in
	    do{
	        let todoItems : [TodoItem]  = try PersistenceManagerMySQL.sharedInstance.todoItemRepository.list()
	        print (NSJSONSerialization.isValidJSONObject (todoItems ))
	  	
	        let json = try TodoItem.encodeList(todoItems );
	        addHeader("content-type", value: "application/json")
        addHeader("Access-Control-Allow-Origin", value:"*")
	  	}catch{
	  	  response.setStatus (500, message: "Could not list TodoItem data")
	  	}
	    //response.appendBodyString("Index handler: You accessed path \(request.requestURI())")
	    next()
	  }
	
	
	  Router.sharedInstance.post("/api/todoItem"){ request, response, next in
	     let todoItem = TodoItem() 
	     do {
	    	try todoItem.decode(request.postBodyString);
	    	let result = try PersistenceManagerMySQL.sharedInstance.todoItemRepository.insert(todoItem)
	    	let json = try todoItem.encode()
	    	try response.outputJson(json)
	    }catch{
	        response.appendBodyString("Error accessing data:  \(error)")
	    }
	    next()
	 }
	
	
	 Router.sharedInstance.get("/api/todoItem/:id"){ request, response, next in
	   let id = Int(request.params["id"]!)
	    do{
	        let todoItem : TodoItem  = try PersistenceManagerMySQL.sharedInstance.todoItemRepository.retrieve(id!)!
	        let json = try todoItem.encode()
	        try response.outputJson(json)
	    }catch{
	        response.setStatus (500, message: "Could not retrieve TodoItem \(id) data")
	    }
	    next()
	 }
	
	 Router.sharedInstance.put("/api/todoItem"){ request, response, next in
	    do {
	     	let todoItem = TodoItem() 
	    	try todoItem.decode(request.postBodyString);
	    	let result = try PersistenceManagerMySQL.sharedInstance.todoItemRepository.update(todoItem)
	    	let json = try todoItem.encode()
	    	try response.outputJson(json)
	    }catch{
	        response.appendBodyString("Error accessing data:  \(error)")
	    }
	    next()
	 }
	
	
	 Router.sharedInstance.delete("/api/todoItem/:id"){ request, response, next in
	    let id = Int(request.params["id"]!)
	    do{
	        let result = try PersistenceManagerMySQL.sharedInstance.todoItemRepository.delete(id!)
	        //let json = try todoItem.encode()
	        try response.outputJson("{\"id\":\(id),\"message\":\"deleted\"}")
	    }catch{
	        response.setStatus (500, message: "Could not delete TodoItem \(id) data")
	    }
	    next()
	 }
  }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 25.69 minutes to type the 2569+ characters in this file.
 */


