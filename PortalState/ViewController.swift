//
//  ViewController.swift
//  PortalState
//
//  Created by Kilian Költzsch on 06/04/15.
//  Copyright (c) 2015 Kilian Koeltzsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	enum portalState {
		case enl
		case res
		case gry
		case unk
	}

	var currentPortalState: portalState?

	override func viewDidLoad() {
		super.viewDidLoad()

		makeRequest()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func setBackgroundColor() {
		if let currentPortalState = currentPortalState {
			switch currentPortalState {
			case .enl:
				self.view.backgroundColor = UIColor(red: 39.0/255.0, green: 174.0/255.0, blue: 96.0/255.0, alpha: 1.0)
			case .res:
				self.view.backgroundColor = UIColor(red: 41.0/255.0, green: 128.0/255.0, blue: 185.0/255.0, alpha: 1.0)
			case .gry:
				self.view.backgroundColor = UIColor.lightGrayColor()
			case .unk:
				self.view.backgroundColor = UIColor.darkGrayColor()
			}
		}
	}

	func makeRequest() {
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		let url = NSURL(string: "")!
		let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {(data, response, err) in

			var stringData = NSString(data: data, encoding: NSUTF8StringEncoding)!

			// too lazy to parse json
			if ((stringData as String).rangeOfString("ENL") != nil) {
				self.currentPortalState = .enl
			} else if ((stringData as String).rangeOfString("RES") != nil) {
				self.currentPortalState = .res
			} else if ((stringData as String).rangeOfString("GRY") != nil) {
				self.currentPortalState = .gry
			} else if ((stringData as String).rangeOfString("UNK") != nil) {
				self.currentPortalState = .unk
			}

			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
				self.setBackgroundColor()
			})

		})
		task.resume()
	}

	@IBAction func screenTapped(sender: UIButton) {
		makeRequest()
	}
	

}

