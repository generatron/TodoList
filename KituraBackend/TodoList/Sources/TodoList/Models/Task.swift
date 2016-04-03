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
Filename:     Task.swift
Description:  Class that holds the data for Task
Project:      TodoList
Template: /Kitura-REST/server/Entity.swift.vm
 */
//Data class for Task
import SwiftyJSON
import Foundation

class Task  {

    var description : Text!
    var id : Int!
    var title : String!
    var todo : TodoItem!
    
    
  func toDictionary() -> Dictionary<String, AnyObject> {
		var dict =  Dictionary<String, AnyObject>()
		if(description != nil){
			dict["description"] = description
		}
		if(id != nil){
			dict["id"] = id
		}
		if(title != nil){
			dict["title"] = title
		}
		if(todo != nil){
			dict["todo"] = todo
		}
		return dict        
	}
	
	func serialize() -> JSON {
		let json =  JSON(toDictionary())
		return json        
	}
	
    func deserialize(json : JSON) throws -> Void {
      
		if(json["description"] != nil){
//description =  json["description"].deserialize()
		}
		if(json["id"] != nil){
     		id =  json["id"].int
		}
		if(json["title"] != nil){
     		title =  json["title"].string
		}
		if(json["todo"] != nil){
//todo =  json["todo"].deserialize()
		}
		
    }   
    func deserialize(jsonString : String) throws -> Void {
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
    		let json = JSON(data: dataFromString)
		if(json["description"] != nil){
//description =  json["description"].deserialize()
		}
		if(json["id"] != nil){
     		id =  json["id"].int
		}
		if(json["title"] != nil){
     		title =  json["title"].string
		}
		if(json["todo"] != nil){
//todo =  json["todo"].deserialize()
		}
		}
    }
    
	func encode() throws -> JSON! {
        let json = serialize()
        return json 
    }
    
    static func encodeList(elements : Array<Task>) throws -> JSON {
          var list = [JSON]();
          for element in elements {
              let json = element.serialize()
              list.append(json)
          }
          return JSON(list)
    }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 19.05 minutes to type the 1905+ characters in this file.
 */
