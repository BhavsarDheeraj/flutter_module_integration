//
//  ViewController.swift
//  flutter poc app
//
//  Created by Dheeraj on 22/07/21.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func navigateButtonPressed(_ sender: UIButton) {
        let flutterEngine = ((UIApplication.shared.delegate as? AppDelegate)?.flutterEngine)!;
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil);
        flutterViewController.modalPresentationStyle = .fullScreen
        self.present(flutterViewController, animated: true, completion: nil)
        
        
        let messageChannel = FlutterMethodChannel(name: "com.dheerajbhavsar.flutter_poc/data", binaryMessenger: flutterViewController.binaryMessenger)
        let data = [
            "message":"Hello from iOS 👋🏻"
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted), let jsonString = String(data: jsonData, encoding: .utf8) else {
            return
        }
        messageChannel.invokeMethod("fromHostToClient", arguments: jsonString)
    }

}

