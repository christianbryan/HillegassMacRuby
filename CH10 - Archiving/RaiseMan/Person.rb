# Person.rb
# RaiseMan
#
# Created by daniellopes on 10/04/10.
# Copyright 2010 area criacoes. All rights reserved.

class Person

  attr_accessor :personName, :expectedRaise
  
  def initialize
    @personName = "New person"
		@expectedRaise = 5.0
  end
  
  def encodeWithCoder(coder)
    coder.encodeObject(personName, forKey:"personName")
    coder.encodeObject(expectedRaise, forKey:"expectedRaise")
  end
  
  def initWithCoder(coder)
    @personName = coder.decodeObjectForKey("personName")
    @expectedRaise = coder.decodeObjectForKey("expectedRaise")
    self
  end
  
end