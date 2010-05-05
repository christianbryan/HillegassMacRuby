# foo.rb
# RandomApp as expanded in Chapter 2
# 
# Created by Christian Bryan on 03/02/2010.
# Copyright 2010 Joe Bloggs. All rights reserved.

class Foo
	attr_accessor :textField
	def seed(sender)
		srand
		@textField.stringValue = "Generator seeded"
	end
	
	def generate(sender)
		generated = rand(100) 
		NSLog("generated = #{generated}")
		@textField.intValue = generated
	end
	
	def awakeFromNib
		now = NSCalendarDate.calendarDate 
		@textField.objectValue = now
	end
end


