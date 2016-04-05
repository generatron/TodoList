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
Filename:     Status.swift
Description:  Class that holds the data for Status
Project:      TodoList
Template: /Kitura-REST/server/Entity.swift.vm
 */

import SwiftyJSON
import Foundation

class Status  {

    var id : Int!
    var name : String!
    
    
  func toDictionary() -> Dictionary<String, AnyObject> {
		var dict =  Dictionary<String, AnyObject>()
		if(id != nil){
		   dict["id"] = id

		}
		if(name != nil){
		   dict["name"] = name

		}
		return dict        
	}
	
	func serialize() -> JSON {
		let json =  JSON(toDictionary())
		return json        
	}
	
    func deserialize(json : JSON) throws -> Void {
      
		if(json["id"] != nil){
     		id =  json["id"].int
		}
		if(json["name"] != nil){
     		name =  json["name"].string
		}
		
    }   
    func deserialize(jsonString : String) throws -> Void {
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
    		let json = JSON(data: dataFromString)
			if(json["id"] != nil){
				id =  json["id"].int 
			}
			if(json["name"] != nil){
				name =  json["name"].string 
			}
		}
    }
    
	func encode() throws -> JSON! {
        let json = serialize()
        return json 
    }
    
    static func encodeList(elements : Array<Status>) throws -> JSON {
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
approximately 13.86 minutes to type the 1386+ characters in this file.
 */
