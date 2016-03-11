
import PackageDescription

let package = Package(
    name: "TodoList",

    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura-router.git", majorVersion: 0),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 0),
        .Package(url: "https://github.com/groue/GRMustache.swift", majorVersion: 1, minor: 0),
    ]

)
