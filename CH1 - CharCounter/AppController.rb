# AppController.rb
# CharCounter
#
# Created by daniellopes on 10/04/10.
# Copyright 2010 area criacoes. All rights reserved.


class AppController
	attr_accessor :textField, :label

	def countChars(sender)
		label.stringValue = "You type: #{textField.stringValue.size} chars"
	end

end