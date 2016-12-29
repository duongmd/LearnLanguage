//
//  DataBase.swift
//  LearnLanguage
//
//  Created by PIRATE on 11/22/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class DataBase {
    
    static let sharedInstance = DataBase()
    var databasePath = NSString()
    private init ()
    {
        getPath()
    }
    
    func getPath()
    {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = NSString(string: dirPaths[0])
        databasePath = docsDir.appendingPathComponent("english.db") as NSString
        print(databasePath)
        
    }
    
    func createDatabase() -> Bool
    {
        
        let filemgr = FileManager.default
        
        if !filemgr.fileExists(atPath: databasePath as String) {
            
            let englishDB = FMDatabase(path: databasePath as String)
            
            if englishDB == nil {
                
                print("Error: \(englishDB?.lastErrorMessage())")
            }
            
            
            if (englishDB?.open())! {
                let sql_Create_Language = "create table if not exists Language(ID integer primary key autoincrement , LanguageName text , UrlImg text, IdUser text)"

                let sql_Create_Word = "create table if not exists WORD(ID integer primary key autoincrement, LANGUAGEID integer, NameWord text, Mean text, WordForm text, Image text, Bool text)"
                

                let sql_Create_Video = "create table if not exists Video(ID integer primary key autoincrement , VideoName text , Sub text , Link text, LanguageID integer) "
                
                let sql_Create_Record = "create table if not exists Record(ID integer primary key autoincrement , RecordName text , LanguageID integer)"
                
                if !(englishDB?.executeStatements(sql_Create_Language))!
                {
                    print("Error: \(englishDB?.lastErrorMessage())")
                    
                }
                

                if !(englishDB?.executeStatements(sql_Create_Word))!
                {
                    print("Error: \(englishDB?.lastErrorMessage())")
                    
                }

                if !(englishDB?.executeStatements(sql_Create_Video))!

                {
                    print("Error: \(englishDB?.lastErrorMessage())")
                    
                }
                

                
                 if !((englishDB?.executeStatements(sql_Create_Record))!)
                 {
                    print("Error: \(englishDB?.lastErrorMessage())")

                }


                if !(englishDB?.executeStatements("PRAGMA foreign_keys = ON" ))! //Nếu thêm 1 trường mà đã trùng với foreign key thì ko cho thêm
                {
                    print("Error:\(englishDB?.lastErrorMessage())")
                }
            }
            else {
                print("Error: \(englishDB?.lastErrorMessage())")
            }
            englishDB?.close()
            return true
        }
        return false
        
    }
    func insertDataBase(_ nameTable : String , dict : NSDictionary)
    {
        var keys = String()
        var values = String()
        var first = true
        for key in dict.allKeys
        {
            if (first == true)
            {
                keys = "'" + (key as! String) + "'"
                values = "'" + (dict.object(forKey: key) as! String) + "'"
                first = false
                continue
            }
            
            keys = keys + "," + "'" + (key as! String) + "'"
            values = values + "," + "'" + (dict.object(forKey: key) as! String) + "'"
        }
        let englishDB = FMDatabase(path: databasePath as String)
        if (englishDB?.open())! {
            if !(englishDB?.executeStatements("PRAGMA foreign_keys = ON"))!
            {
                print("Error: \(englishDB?.lastErrorMessage())")
            }
            let insertSQL = "INSERT INTO \(nameTable) (\(keys)) VALUES (\(values))"
            let result = englishDB?.executeUpdate(insertSQL, withArgumentsIn: nil)
            
            if !result! {
                print("Error: \(englishDB?.lastErrorMessage())")
            }
        }
        englishDB?.close()
    }
    
    func deleteDatabase ( _ nameTable: String , ID : Int)
    {
        let englishDB = FMDatabase(path: databasePath as String)
        if (englishDB?.open())! {
            if !(englishDB?.executeStatements("PRAGMA foreign_keys = ON"))!
            {
                print("Error: \(englishDB?.lastErrorMessage())")
            }
            let deleteSQL = "DELETE FROM \(nameTable) WHERE ID = \(ID)"
            let result = englishDB?.executeUpdate(deleteSQL, withArgumentsIn: nil)
            
            if !result! {
                print("Error : \(englishDB?.lastErrorMessage())")
            }
        }
        englishDB?.close()
    }
    
    func deleteWordDatabase ( _ nameTable: String , ID : Int)
    {
        let englishDB = FMDatabase(path: databasePath as String)
        if (englishDB?.open())! {
            if !(englishDB?.executeStatements("PRAGMA foreign_keys = ON"))!
            {
                print("Error: \(englishDB?.lastErrorMessage())")
            }
            let deleteSQL = "DELETE FROM \(nameTable) WHERE LANGUAGEID = \(ID)"
            let result = englishDB?.executeUpdate(deleteSQL, withArgumentsIn: nil)
            
            if !result! {
                print("Error : \(englishDB?.lastErrorMessage())")
            }
        }
        englishDB?.close()
    }
    
    func viewDatabase (_ table: String ,columns :[String], statement: String) -> [ NSDictionary]
    {
        var allColumns = ""
        var items = [NSDictionary]()
        for column in columns
        {
            if (allColumns == "")
            {
                allColumns = column
            }
            else {
                allColumns = allColumns + "," + column
                
            }
        }
        let querySQL = "Select \(allColumns) From \(table) \(statement)"
        
        let englishDB = FMDatabase(path: databasePath as String)
        
        
        if (englishDB?.open())! {
            let results: FMResultSet? = englishDB?.executeQuery(querySQL, withArgumentsIn: nil)
            while ((results?.next()) == true)
            {
                items.append(results!.resultDictionary() as NSDictionary)
            }
        }
        englishDB?.close()
        return items
        
        
    }
}
