//
//  Objects.swift
//  18120254
//
//  Created by HUYTU on 11/20/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import Foundation
import RealmSwift




class Event: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var font: String = ""
    @objc dynamic var fontSize: Int = 17 // minimum font size
    @objc dynamic var fontColor: String = "[0.0, 0.0, 0.0, 1.0]" // default is black
    var records = List<Record>()
}

class Record: Object  {
    @objc dynamic var name: String = ""
    @objc dynamic var guests: String = ""
    @objc dynamic var table: String = ""
    @objc dynamic var section: String = ""

}

// INIT FUNCTION

// make a event
func makeEvent(_name: String, _font: String, _fontsize: Int, _fontColor: String, _records: [Record]) -> Event {
    let event = Event()
    event.name = _name
    event.font = _font
    event.fontSize = _fontsize
    event.fontColor = _fontColor
    let listRecord = List<Record>()
    for aRecord in _records {
        listRecord.append(aRecord)
    }
    event.records = listRecord
    return event
}

// make a record
func makeRecord(_name: String = "", _guests: String = "", _table: String = "", _section: String = "") -> Record {
    let record = Record()
    record.name = _name
    record.guests = _guests
    record.table = _table
    record.section = _section
    return record
}

// DATABASE FUNCTION

// check if DB is nil
func checkNilDB(_realm: Realm) -> Bool {
    var isNil = false
    let event = _realm.objects(Event.self)
    if event.isEmpty == true {
        isNil = true
    }
    return isNil
}

// delete DB (when user create new event)
func deleteDB(_realm: Realm) {
    // delete event
    let allEvents = _realm.objects(Event.self)
    for event in allEvents {
        try! _realm.write{
            _realm.delete(event)
        }
    }
    // delete records
     let allRecords = _realm.objects(Record.self)
     for record in allRecords {
         try! _realm.write{
             _realm.delete(record)
         }
     }
    
}

// load latest event data from DB
func readEventFromDB(_realm: Realm) -> Event {
    if checkNilDB(_realm: _realm) == true {
        let eventRead = Event()
        return eventRead
    }
    else {
        let allEvents = _realm.objects(Event.self).last!
        let eventRead = makeEvent(_name: allEvents.name, _font: allEvents.font, _fontsize: allEvents.fontSize, _fontColor: allEvents.fontColor, _records: Array(allEvents.records))
        return eventRead
    }
}

// add a event to DB
func addEventToDB(_realm: Realm, _event: Event) {
    let myEvent = makeEvent(_name: _event.name, _font: _event.font, _fontsize: _event.fontSize, _fontColor: _event.fontColor, _records: Array(_event.records))
    try! _realm.write{
        _realm.add(myEvent)
    }
}







