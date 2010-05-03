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

end
