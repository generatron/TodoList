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

class TodoItem  {
    var completed : Bool!
    var id : String!
    var order : Int!
    var title : String!
    var url : String!
    
    
    func serialize() -> JSONDictionary {
		var dict =  JSONDictionary()
		if(completed != nil){
			dict["completed"] = completed
		}
		if(id != nil){
			dict["id"] = id
		}
		if(order != nil){
			dict["order"] = order
		}
		if(title != nil){
			dict["title"] = title
		}
		if(url != nil){
			dict["url"] = url
		}
		return dict        
	}
	
	func toJSON() -> JSON {
		var json =  JSON()
		if(completed != nil){
			json["completed"] = completed
		}
		if(id != nil){
			json["id"] = id
		}
		if(order != nil){
			json["order"] = order
		}
		if(title != nil){
			json["title"] = title
		}
		if(url != nil){
			json["url"] = url
		}
		return json        
	}
    
    
    func deserialize(jsonString : String) throws -> Void {
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
    		let json = JSON(data: dataFromString)
		if(json["completed"] != nil){
     		completed =  json["completed"] as! Bool
		}
		if(json["id"] != nil){
     		id =  json["id"] as! String
		}
		if(json["order"] != nil){
     		order =  json["order"] as! Int
		}
		if(json["title"] != nil){
     		title =  json["title"] as! String
		}
		if(json["url"] != nil){
     		url =  json["url"] as! String
		}
		}
    }
    
	func encode() throws -> String! {
        let json = toJSON()
        return json.rawString
    }
    
    static func encodeList(elements : Array<TodoItem>) throws -> String {
        var payload : Array<JSONDictionary> = [];
        do {
        elements.forEach { todoItem -> () in
                payload.append(todoItem.serialize());
           
        }
          var encoded = JSON(payload).rawString
          return encoded
        }catch{
            print(error)
        }
        return ""
    }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 20.43 minutes to type the 2043+ characters in this file.
 */
