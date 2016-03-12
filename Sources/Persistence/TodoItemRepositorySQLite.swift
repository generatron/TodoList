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
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
		try stmt.bind(":completed", entity.completed)
		try stmt.bind(":id", entity.id)
		try stmt.bind(":order", entity.order)
		try stmt.bind(":title", entity.title)
		try stmt.bind(":url", entity.url)
        }
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Insert(errCode)
        }
        return db.changes()
    }
    
    func update(entity: TodoItem) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE TodoItem SET completed=:completed ,order=:order ,title=:title ,url=:url WHERE id = ?"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
		try stmt.bind(":completed", entity.completed)
		try stmt.bind(":id", entity.id)
		try stmt.bind(":order", entity.order)
		try stmt.bind(":title", entity.title)
		try stmt.bind(":url", entity.url)
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Update(errCode)
        }
        
        return db.changes()
    }
    
    func delete(entity: TodoItem) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "DELETE FROM todoItem WHERE id = :id"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
            try stmt.bind(":id", id)
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Delete(errCode)
        }
        
        return db.changes()
    }
    
    func retrieve(id: Int) throws -> TodoItem? {
        let sql = "SELECT * FROM todoItem WHERE id = :id"
        var columns = [Any]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            try stmt.bind(":id", id)
        }) { (stmt:SQLiteStmt, r:Int) -> () in
			columns.append(stmt.columnText(0))
			columns.append(stmt.columnText(1))
			columns.append(stmt.columnInt(2))
			columns.append(stmt.columnText(3))
			columns.append(stmt.columnText(4))
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Select(errCode)
        }
        
        guard columns.count > 0 else {
            return nil
        }
        
        return TodoItem(
completed: columns[0] as? Bool
,id: columns[1] as? String
,order: columns[2] as? Int
,title: columns[3] as? String
,url: columns[4] as? String
        )
    }
    
    func list() throws -> [TodoItem] {
        let sql = "SELECT * FROM todoItem "
        var entities = [TodoItem]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            //nothing to see here
        }) { (stmt:SQLiteStmt, r:Int) -> () in
        	entities.append(
        		TodoItem(
completed: columns[0] as? Bool
,id: columns[1] as? String
,order: columns[2] as? Int
,title: columns[3] as? String
,url: columns[4] as? String
        		)
        	)
        }
        return entities
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 36.91 minutes to type the 3691+ characters in this file.
 */


