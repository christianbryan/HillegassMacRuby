# AppController.rb
# SpeakLine
#
# Created by daniellopes on 10/04/10.
# Copyright 2010 area criacoes. All rights reserved.

class AppController
		attr_accessor :textField, :startButton, :stopButton
		
		def initialize
			p "init"
			@speechSynth = NSSpeechSynthesizer.new.initWithVoice(nil)	
			@speechSynth.delegate = self
		end
		
		def	sayIt(sender)
			string = textField.stringValue
			return if string.empty?
			@speechSynth.startSpeakingString(string)
			@startButton.enabled = false
			@stopButton.enabled = true		
		end
		
		def	stopIt(sender)
			@speechSynth.stopSpeaking
		end
		
		def speechSynthesizer(sender, didFinishSpeaking:complete)
			@startButton.enabled = true
			@stopButton.enabled = false		
		end
end