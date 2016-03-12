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
Filename:     TodoItemRepositoryMySQL.swift
Description:  Persistence code for for TodoItem
Project:      TodoList
Template: /Kitura/server/EntityRepositoryMySQL.swift.vm
 */

import MySQL
class TodoItemRepositoryMySQL : TodoItemRepository,RepositoryMySQL {

func createStorage() throws ->  Int {
   let rs = try db.query("CREATE TABLE IF NOT EXISTS TodoItem (completed BIT, id VARCHAR(255) NOT NULL AUTO_INCREMENT, order INT(10), title VARCHAR(255), url VARCHAR(255), PRIMARY KEY (id))")
   let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.CreateTable(errorCode)
      }
      return 0;
}
func insert(entity: TodoItem) throws -> Int {
       	let sql = "INSERT INTO TodoItem(completed,order,title,url) VALUES ( ?, ?, ?, ?)"
       	PersistenceManagerMySQL.sharedInstance.checkConnection();
       	let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		if(prepRes){

		if(entity.completed != nil){
			statement.bindParam(entity.completed)
		}else{
			statement.bindParam()
		}
		

		if(entity.order != nil){
			statement.bindParam(entity.order)
		}else{
			statement.bindParam()
		}
		

		if(entity.title != nil){
			statement.bindParam(entity.title)
		}else{
			statement.bindParam()
		}
		

		if(entity.url != nil){
			statement.bindParam(entity.url)
		}else{
			statement.bindParam()
		}
		

			let execRes = statement.execute()
			if(execRes){
				entity.id = Int(statement.insertId()) ;
				return entity.id
			}else{
				print("\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
				    throw RepositoryError.Insert(errorCode)
				}
			}
				
			statement.close()
	}        
 	return 0
	}
    
	func update(entity: TodoItem) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE TodoItem SET completed= ? ,order= ? ,title= ? ,url= ? WHERE id = ?"
PersistenceManagerMySQL.sharedInstance.checkConnection();
let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		
		if(prepRes){		

		if(entity.completed != nil){
			statement.bindParam(entity.completed)
		}else{
			statement.bindParam()
		}
		

		if(entity.order != nil){
			statement.bindParam(entity.order)
		}else{
			statement.bindParam()
		}
		

		if(entity.title != nil){
			statement.bindParam(entity.title)
		}else{
			statement.bindParam()
		}
		

		if(entity.url != nil){
			statement.bindParam(entity.url)
		}else{
			statement.bindParam()
		}
		
			statement.bindParam(entity.id)
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
    
	func delete(id: Int) throws -> Int {
	PersistenceManagerMySQL.sharedInstance.checkConnection();
	    let sql = "DELETE FROM todoItem WHERE id = \(id)"
	    let queryResult = db.query(sql)
	    return id;
	}
    
    func retrieve(id: Int) throws -> TodoItem? {
        let sql = "SELECT completed,id,order,title,url FROM TodoItem WHERE id = \(id)"
        PersistenceManagerMySQL.sharedInstance.checkConnection();
		let queryResult = db.query(sql)
		 if(queryResult){
        let results = db.storeResults()!
  		let todoItem = TodoItem()
        while let row = results.next() {
						if(row[0] == "1"){
			   	todoItem.completed = Bool(true);
			}else{
				todoItem.completed = Bool(false);
			}

	todoItem.id = String(row[1]);
	
	todoItem.order = Int(row[2]);
	
	todoItem.title = String(row[3]);
	
	todoItem.url = String(row[4]);
	
            print(row)
        }
        results.close()
	    return todoItem;
	    }else{
				print(" \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
				    throw RepositoryError.Retrieve(errorCode)
				}
			}
			return nil;
    }
    
    func list() throws -> [TodoItem]  {
        let sql = "SELECT completed,id,order,title,url FROM TodoItem "
        PersistenceManagerMySQL.sharedInstance.checkConnection();
        var entities = [TodoItem]()
         let queryResult = db.query(sql)
        if(queryResult){

		let results = db.storeResults()!
  
        while let row = results.next() {
        	let todoItem = TodoItem()
						if(row[0] == "1"){
			   	todoItem.completed = Bool(true);
			}else{
				todoItem.completed = Bool(false);
			}

	todoItem.id = String(row[1]);
	
	todoItem.order = Int(row[2]);
	
	todoItem.title = String(row[3]);
	
	todoItem.url = String(row[4]);
	
			entities.append(todoItem)
            print(row)
        }
        results.close()
        return entities
			}else{
				print(" \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
				    throw RepositoryError.List(errorCode)
				}
				return [];
			}
			
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 50.92 minutes to type the 5092+ characters in this file.
 */


