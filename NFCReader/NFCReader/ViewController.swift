//
//  ViewController.swift
//  NFCReader
//
//  Created by Pavan Kumar C on 04/09/18.
//  Copyright © 2018 pavan. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {

    var nfcSession: NFCNDEFReaderSession?

    @IBOutlet weak var statusLabel: UILabel!

    //MARK: - Controller life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - IBAction Delegate methods

    @IBAction func scanClicked(_ sender: UIButton) {
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.begin()
    }

    //MARK:- NFC Reader Session delegate methods

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Parse the card's information
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload, encoding: .utf8)! // 1
        }

        DispatchQueue.main.async {
            self.statusLabel.text = result
        }
    }

}

