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
Filename:     TodoItem.swift
Description:  Class that holds the data for TodoItem
Project:      TodoList
Template: /Kitura/server/Entity.swift.vm
 */
//Data class for TodoItem
import SwiftyJSON
import Foundation

class TodoItem  {
    var completed : Bool!
    var id : String!
    var order : Int!
    var title : String!
    var url : String!
    
	func serialize() -> JSON {
		let json =  JSON(self)
		return json        
	}
    
    
    func deserialize(jsonString : String) throws -> Void {
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
    		let json = JSON(data: dataFromString)
		if(json["completed"] != nil){
     		completed =  json["completed"].bool
		}
		if(json["id"] != nil){
     		id =  json["id"].string
		}
		if(json["order"] != nil){
     		order =  json["order"].int
		}
		if(json["title"] != nil){
     		title =  json["title"].string
		}
		if(json["url"] != nil){
     		url =  json["url"].string
		}
		}
    }
    
	func encode() throws -> String! {
        let json = serialize()
        return json.string 
    }
    
    static func encodeList(elements : Array<TodoItem>) throws -> String {
        do {
          return JSON(elements).string
        }catch{
            print(error)
        }
        
    }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 12.06 minutes to type the 1206+ characters in this file.
 */
