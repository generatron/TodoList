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
Filename:     PersistenceManagerMySQL.swift
Description:  MySQL PersistenceManager: an Adapter to deal with persistence layer
Project:      TodoList
Template: /Kitura-REST/server/PersistenceManagerMySQL.swift.vmg
 */

import MySQL

class PersistenceManagerMySQL : PersistenceManager {
	static let sharedInstance = PersistenceManagerMySQL()
    var mysql = MySQL ()
    
    var statusRepository :  StatusRepositoryMySQL! 
    var taskRepository :  TaskRepositoryMySQL! 
    var todoItemRepository :  TodoItemRepositoryMySQL! 

    init() {
    }
    
    func connect() {
    	// Connect to Database.
    	let datasource : GeneratronDataSource = Config.sharedInstance.datasources["mysql"]!
    	do {
        	 let connect = mysql.connect (datasource.host, user:datasource.user, password: datasource.password)
	        if (connect)
	        {
	            let selectedSchema = mysql.selectDatabase (datasource.schema)
	            if (selectedSchema)
	            {
				
				//Variables for Status
				statusRepository = StatusRepositoryMySQL(db:self.mysql);
				try statusRepository.createStorage()
				
				//Variables for Task
				taskRepository = TaskRepositoryMySQL(db:self.mysql);
				try taskRepository.createStorage()
				
				//Variables for TodoItem
				todoItemRepository = TodoItemRepositoryMySQL(db:self.mysql);
				try todoItemRepository.createStorage()
				}
			}

    	} catch (let e){
        	print("Failure connecting to MYSQL DB")
        	print(e)
    	}
    	
    }
    
    func checkConnection() -> Bool {
    	let sql = "SELECT 1"
		let queryResult = db.query(sql)
		if(!queryResult){
			connect()
		}
		return queryResult
    }
	 func disconnect() throws {
	 }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 15.28 minutes to type the 1528+ characters in this file.
 */
