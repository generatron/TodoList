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
Filename:     TodoItemRepositorySQLite.swift
Description:  Persistence code for for TodoItem
Project:      TodoList
Template: /Kitura/server/EntityRepositorySQLite.swift.vm
 */

import SQLite
class TodoItemSQLiteRepository : TodoItemRepository,RepositorySQLite {
func createStorage() throws ->  Int {
	do {
		let sqlite = self.db
		defer {
			sqlite.close()
		}
		try sqlite.execute("CREATE TABLE IF NOT EXISTS TodoItem (completed NUMBER, id TEXT, order NUMBER, title TEXT, url TEXT, PRIMARY KEY (id))")
	} catch let e {
		print("Exception creating SQLite Table for TodoItem \(e)")
	}
   
}
func insert(entity: TodoItem) throws -> Int {
       	let sql = "INSERT INTO TodoItem(completed,order,title,url) VALUES ( :completed, :order, :title, :url)"
   do {    	
       	let sqlite = self.db
		defer {
			sqlite.close()
		}
		
		
    try sqlite.execute(sql) {
	(statement:SQLiteStmt) -> () in
				
	statement.bind(":completed",entity.completed)
	statement.bind(":id",entity.id)
	statement.bind(":order",entity.order)
	statement.bind(":title",entity.title)
	statement.bind(":url",entity.url)
   }
							
let lastId = sqlite.lastInsertRowID()
	
} catch let e {
		print("Exception creating SQLite Table for TodoItem \(e)")
}
}
    
    func update(entity: TodoItem) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE TodoItem SET completed=:completed ,order=:order ,title=:title ,url=:url WHERE id = ?"

let statement = SQLiteStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		
		if(prepRes){		
	statement.bindParam(entity.completed)
	statement.bindParam(entity.id)
	statement.bindParam(entity.order)
	statement.bindParam(entity.title)
	statement.bindParam(entity.url)

let execRes = statement.execute()
if(!execRes){
	print("\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())")
	let errorCode = db.errorCode()
	if errorCode > 0 {
	    throw RepositoryError.Update(errorCode)
	}
}
	
statement.close()
		}
        
		return 0
    }
    
	func delete(entity: TodoItem) throws -> Int {
	    guard let id = entity.id else {
	        return 0
	    }
	    
	    let sql = "DELETE FROM todoItem WHERE id = ?"
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
				print("\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
	    			throw RepositoryError.Delete(errorCode)
				}
				statement.close()
			}
				
		}
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
        let sql = "SELECT * FROM todoItem "
        var entities = [TodoItem]()
        var columns = [Any]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            //nothing to see here
        }) { (stmt:SQLiteStmt, r:Int) -> () in
                let entity =  TodoItem()
		entity.completed = stmt.columnText(0)
		entity.id = stmt.columnText(1)
		entity.order = stmt.columnInt(2)
		entity.title = stmt.columnText(3)
		entity.url = stmt.columnText(4)
        	    entities.append(entity)
        }
        return entities
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 42.9 minutes to type the 4290+ characters in this file.
 */


