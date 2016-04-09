
![Generatron](https://www.generatron.com/logosmall.png)

Engineered with [Kitura-REST](https://www.generatron.com//#/generatron/Kitura-REST)

#TodoList


## Installing and Running

1. Build TodoList application

  1. Mac OS X: 
	
	`swift build -Xcc -fblocks -Xswiftc -I/usr/local/include -Xlinker -L/usr/local/lib`
	
  2. Linux:
  
    `swift build -Xcc -fblocks`
	
2. Run the TodoList application:

	`./.build/debug/TodoList`
	
3. Open up your browser, and view: 

   [http://localhost:9000](http://localhost:9000)

4. Generate a project file for  TodoList application
swift build --generate-xcodeproj .

## Tests

  To run unit tests, run:
  
  `swift test`

## Links

   
   [Kitura ](https://github.com/IBM-Swift/Kitura)
   
   [Kitura TodoList Sample](https://github.com/IBM-Swift/Kitura-TodoList)
   
   [Swift](https://swift.org/)
   
 
