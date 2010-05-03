class AppController
	attr_accessor :fido, :label
	
	def initialize
	  @fido = 10.0
  end
	
	def setFido(val)
		p val
		@label.setStringValue(@fido.to_i.to_s)
		@fido = val
	end
	
	def incrementFido(sender)
    self.setValue(@fido+1, forKey:"fido")
	end

end