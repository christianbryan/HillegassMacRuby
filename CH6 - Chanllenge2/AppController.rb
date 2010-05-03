# AppController.rb
# CH6 - Chanllenge2
#
# Created by daniellopes on 10/04/10.
# Copyright 2010 area criacoes. All rights reserved.
class AppController
  attr_accessor :newItem, :toDoTableView, :toDoList
  
  def initialize
    @toDoList =[]
  end
  
  def add(sender)
    @toDoList << newItem.stringValue
    @toDoTableView.reloadData
  end
  
  def numberOfRowsInTableView(tv)
    @toDoList.length
  end
  
  def tableView(tv, objectValueForTableColumn:tableColumn, row:row)
    @toDoList[row]
  end
  
  def tableView(tv, setObjectValue:anObject, forTableColumn:col, row:row)
    @toDoList[row] = anObject
    @toDoTableView.reloadData
  end
end