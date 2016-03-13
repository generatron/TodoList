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
Template: /Kitura/server/EntityRepositoryMemory.swift.vm
 */

import KituraSys
import LoggerAPI
import SwiftyJSON

import Foundation


class TodoItemRepositoryMemory : TodoItemRepository {


    var baseURL: String
    
    ///
    /// Ensure in order writes to the collection
    ///
    let writingQueue = Queue(type: .SERIAL, label: "Writing Queue")

    ///
    /// Incrementing variable used for new index values
    ///
    var idCounter: Int = 0


  	///
    /// Internal storage of TodoItems as a Dictionary
    ///
    private var _collection = [String: TodoItem]()
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    
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
 var original: String
 original = String(self.idCounter) 
 
 writingQueue.queueSync() {

            self.idCounter+=1

            self._collection[original] = entity

        }
     
 return self.idCounter
}
    
    func update(entity: TodoItem) throws -> Int {

		return 0
    }
    
	func delete(entity: TodoItem) throws -> Int {
		return 0
	}
    
    func retrieve(id: Int) throws -> TodoItem? {
        let sql = "SELECT completed,id,order,title,url FROM TodoItem"
       	let statement = SQLiteStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		
		if(prepRes){
			//HARDCODED might not exist, assuming it does, need to retrieve PK
			statement.bindParam(entity.id)
			
			let execRes = statement.execute()
            if(!execRes){
            	let result = statement.results()
            	
            	let ok = results.forEachRow {
				e in
				print(e.flatMap({ (a:Any?) -> Any? in
					return a!
				}))
				}
			
				print("\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
	    			throw RepositoryError.Delete(errorCode)
				}
				statement.close()
			}
				
		}
	    return entity;
    }
    
    func list() throws -> [TodoItem] {
       return [TodoItem](_collection.values)
    }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 23.36 minutes to type the 2336+ characters in this file.
 */
