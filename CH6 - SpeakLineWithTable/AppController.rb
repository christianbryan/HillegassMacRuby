# AppController.rb
# SpeakLine
#
# Created by daniellopes on 10/04/10.
# Copyright 2010 area criacoes. All rights reserved.

class AppController
		attr_accessor :textField, :startButton, :stopButton, :voiceList, :tableView
		
		def initialize
			p "init"
			@speechSynth = NSSpeechSynthesizer.new.initWithVoice(nil)	
			@speechSynth.delegate = self
			@voiceList = NSSpeechSynthesizer.availableVoices
		end
		
		def	sayIt(sender)
			string = textField.stringValue
			return if string.empty?
			@speechSynth.startSpeakingString(string)
			@startButton.enabled = false
			@stopButton.enabled = true
			@tableView.enabled = false
		end
		
		def	stopIt(sender)
			@speechSynth.stopSpeaking
		end
		
		def speechSynthesizer(sender, didFinishSpeaking:complete)
			@startButton.enabled = true
			@stopButton.enabled = false		
			@tableView.enabled = true			
		end
		
		def numberOfRowsInTableView(tv)
			@voiceList.length
		end
		
		def tableView(tv, objectValueForTableColumn:tableColumn, row:row)
			v = @voiceList[row]
			dict = NSSpeechSynthesizer.attributesForVoice(v)
			dict.objectForKey(NSVoiceName)
		end
		
		def tableViewSelectionDidChange(notification)
			row = @tableView.selectedRow
			return if row == -1

			selectedVoice = voiceList[row]
			@speechSynth.setVoice(selectedVoice)
		end
		
		
		def awakeFromNib
			defaultVoice = NSSpeechSynthesizer.defaultVoice
			defaultRow = voiceList.indexOfObject(defaultVoice)
			@tableView.selectRowIndexes(NSIndexSet.indexSetWithIndex(defaultRow), byExtendingSelection:false)
			@tableView.scrollRowToVisible(defaultRow)
		end
		
end