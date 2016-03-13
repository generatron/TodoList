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
Filename:     PersistenceManagerSQLite.swift
Description:  MySQL PersistenceManager: an Adapter to deal with persistence layer
Project:      TodoList
Template: /Kitura/server/PersistenceManagerSQLite.swift.vmg
 */

import MySQL

class PersistenceManagerSQLite : PersistenceManager {
	static let sharedInstance = PersistenceManagerSQLite()
	let DB_PATH = PerfectServer.staticPerfectServer.homeDir() + serverSQLiteDBs + "TodoList"
	
	
    private var db: SQLite {
		return try! SQLite(DB_PATH)
	}
    
        var todoItemRepository :  TodoItemRepositorySQLite! 
	    
    init() {
    	
    }
    
    func connect() {
    	
    	do {
        let sqlite = self.db
		defer {
			sqlite.close()
		}
        
			//Variables for TodoItem
			todoItemRepository = TodoItemRepositorySQLite(db:self.db);
			try todoItemRepository.createStorage()


    	} catch (let e){
        	print("Exeption creating SQLite DB \(e)")
			File(DB_PATH).delete()
    	}
    	
    }
    
    
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 7.9400005 minutes to type the 794+ characters in this file.
 */
