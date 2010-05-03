#
# MyDocument.rb
# RaiseMan
#
# Created by daniellopes on 10/04/10.
# Copyright area criacoes 2010. All rights reserved.
#

class MyDocument < NSDocument

	attr_accessor :employees, :tableView, :employeeController
	
  def windowControllerDidLoadNib(aController)
    super(aController)
    @employees = [] 
  end
	
	# Name of nib containing document window
	def windowNibName
		'MyDocument'
	end
	
	# Document data representation for saving (return NSData)
	def dataOfType(type, error:outError)
		tableView.window.endEditingFor(nil)
		NSKeyedArchiver.archivedDataWithRootObject(@employees)
	end
	
	# Read document from data (return non-nil on success)
  def readFromData(data, ofType:typeName, error:outError)
    p "about to read data of type #{typeName}"
    new_array = NSKeyedUnarchiver.unarchiveObjectWithData data
    self.setEmployees(new_array)
    return true
  rescue Exception => e
    p "Unable to load the file: an error occured #{e}"
   return false
  end
	
	# Return lowercase 'untitled', to comply with HIG
	def displayName
		fileURL ? super : super.sub(/^[[:upper:]]/) {|s| s.downcase}
	end
	
	# Actions
	def createEmployee(sender)
		w = @tableView.window
		editingEnded = w.makeFirstResponder(w)
		return if (!editingEnded)	
	
		p = @employeeController.newObject
		@employeeController.addObject(p)

		@employeeController.rearrangeObjects
		
		a = @employeeController.arrangedObjects
		row = a.indexOfObjectIdenticalTo(p)
	
		@tableView.editColumn(0, row:row, withEvent:nil, select:true)
	end
	
	# Undoable Methods
  def insertObject(person, inEmployeesAtIndex:index)
    undo = self.undoManager
    undo.prepareWithInvocationTarget(self).removeObjectFromEmployeesAtIndex(index)
    undo.setActionName("Delete Person") if !undo.isUndoing

    self.startObservingPerson(person)		
    @employees.insert(index, person)
  end
	
  def removeObjectFromEmployeesAtIndex(index)
    person = @employees[index]

    undo = self.undoManager
    undo.prepareWithInvocationTarget(self).insertObject(person, inEmployeesAtIndex:index)
    undo.setActionName("Insert Person") if !undo.isUndoing

		self.stopObservingPerson(person)
    @employees.delete_at(index)
  end	
	
  def changeKeyPath(keyPath, ofObject:obj, toValue:newValue)
    obj.setValue(newValue, forKeyPath:keyPath)
  end	
	
	# Observers
  def startObservingPerson(person)
    p "observing person #{person}"
    person.addObserver(self, forKeyPath:"personName", options:NSKeyValueObservingOptionOld, context:nil)
    person.addObserver(self, forKeyPath:"expectedRaise", options:NSKeyValueObservingOptionOld, context:nil)
  end
  
  def stopObservingPerson(person)
    p "stopped observing person #{person}"
    person.removeObserver(self, forKeyPath:"personName")
    person.removeObserver(self, forKeyPath:"expectedRaise")
  end	
  
  def observeValueForKeyPath(keyPath, ofObject:object, change:change, context:context)
    undo = self.undoManager
    oldValue = change[NSKeyValueChangeOldKey]
    oldValue = nil if oldValue == NSNull.null
    p "old value #{oldValue}"
    
    undo.prepareWithInvocationTarget(self).changeKeyPath(keyPath, ofObject:object, toValue:oldValue)
    undo.setActionName("Edit")
  end	

end