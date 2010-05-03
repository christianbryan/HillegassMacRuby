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
end