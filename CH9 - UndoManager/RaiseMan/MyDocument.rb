#
# MyDocument.rb
# RaiseMan
#
# Created by daniellopes on 10/04/10.
# Copyright area criacoes 2010. All rights reserved.
#

class MyDocument < NSDocument

	attr_accessor :employees
	
  def windowControllerDidLoadNib(aController)
    super
    @employees = [] 
  end
	
	# Name of nib containing document window
	def windowNibName
		'MyDocument'
	end
	
	# Document data representation for saving (return NSData)
	def dataOfType(type, error:outError)
		outError.assign(NSError.errorWithDomain(NSOSStatusErrorDomain, code:-4, userInfo:nil))
		nil
	end

	# Read document from data (return non-nil on success)
	def readFromData(data, ofType:type, error:outError)
		outError.assign(NSError.errorWithDomain(NSOSStatusErrorDomain, code:-4, userInfo:nil))
		nil
	end

	# Return lowercase 'untitled', to comply with HIG
	def displayName
		fileURL ? super : super.sub(/^[[:upper:]]/) {|s| s.downcase}
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