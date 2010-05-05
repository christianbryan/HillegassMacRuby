# CarArrayController.rb
# CarLot
#
# Created by daniellopes on 04/05/10.
#  Adapted from 'Cocoa Programming for Mac OS X' - 3rd Edition by Aaron Hillegass (http://www.bignerdranch.com/)

class CarArrayController < NSArrayController
	
	def newObject
		newObj = super
		return newObj.setValue(NSDate.date, forKey:"datePurchased")
	end

end