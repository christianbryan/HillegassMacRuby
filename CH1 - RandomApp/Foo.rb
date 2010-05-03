# Foo.rb
# RandomApp
#
# Created by daniellopes on 09/04/10.
# Copyright 2010 area criacoes. All rights reserved.

class Foo < NSObject
	attr_accessor :textField
	
	def seed(sender)
		rand(Time.now) 
		textField.stringValue = "Generator seeded"
	end
	
	def generate(sender)
		NSLog("generated = #{(rand % 100) + 1}")
	end
	
	def awakeFromNib
		textField.stringValue = Time.now.to_s
	end
end