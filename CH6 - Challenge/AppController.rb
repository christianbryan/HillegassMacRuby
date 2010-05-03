# AppController.rb
# CH6 - Challenge
#
# Created by daniellopes on 10/04/10.
# Copyright 2010 area criacoes. All rights reserved.
class AppController
  def windowWillResize(sender, toSize:frameSize)
	  frameSize.width = 0.5 * frameSize.height if frameSize.width * 2 != frameSize.height 
		frameSize
  end
end