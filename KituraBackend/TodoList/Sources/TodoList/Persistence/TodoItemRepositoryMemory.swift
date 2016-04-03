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
Filename:     TodoItemRepositoryMemory.swift
Description:  Persistence code for for TodoItem
Project:      TodoList
Template: /Kitura-REST/server/EntityRepositoryMemory.swift.vm
 */

import KituraSys
import LoggerAPI
import SwiftyJSON

import Foundation


class TodoItemRepositoryMemory : TodoItemRepository {
    
    ///
    /// Ensure in order writes to the collection
    ///
    let writingQueue = Queue(type: .SERIAL, label: "Writing Queue")

    ///
    /// Incrementing variable used for new index values
    ///
    var idCounter: Int = 0


  	///
    /// Internal storage of TodoItem as a Dictionary
    ///
    private var _collection = [String: TodoItem]()
   
    var count: Int {
        return _collection.keys.count
    }

    func clear() {
        writingQueue.queueSync() {
            self._collection.removeAll()
        }

    }
    
    
	func createStorage() throws ->  Int {
      return 0;
	}
	
	func insert(entity: TodoItem) throws -> Int {
 		writingQueue.queueSync() {
            self.idCounter+=1
            var original: String
 			original = String(self.idCounter)
			entity.id = self.idCounter
			print(entity) 
            self._collection[original] = entity

        }
     
 		return self.idCounter
	}
    
    func update(entity: TodoItem) throws -> Int {
    	let oldValue = self._collection[String(entity.id)]
        
        if oldValue != nil {
            
            // use nil coalescing operator
            
            let newValue = TodoItem()
			if(entity.completed != nil){
				newValue.completed = entity.completed
			}
			if(entity.dueDate != nil){
				newValue.dueDate = entity.dueDate
			}
			if(entity.id != nil){
				newValue.id = entity.id
			}
			if(entity.order != nil){
				newValue.order = entity.order
			}
			if(entity.status != nil){
				newValue.status = entity.status
			}
			if(entity.tasks != nil){
				newValue.tasks = entity.tasks
			}
			if(entity.title != nil){
				newValue.title = entity.title
			}
			if(entity.url != nil){
				newValue.url = entity.url
			}
            _collection.updateValue(newValue, forKey: String(entity.id))
            return 0
            
        } else {
            Log.warning("Could not find item in database with ID: \(entity.id)")
        }

		return 0
    }
    
	func delete(id: Int) throws -> Int {
		self._collection.removeValueForKey(String(id))
		return 0
	}
    
    func retrieve(id: Int) throws -> TodoItem? {
	    return self._collection[String(id) ] 
    }
    
    func list() throws -> [TodoItem] {
       return [TodoItem](_collection.values)
    }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 25.04 minutes to type the 2504+ characters in this file.
 */
