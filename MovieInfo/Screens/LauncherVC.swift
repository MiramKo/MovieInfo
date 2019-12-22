//
//  LauncherVC.swift
//  MovieInfo
//
//  Created by Михаил Костров on 13/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import UIKit

class LauncherVC: UIViewController {
    
    @IBOutlet weak var spool: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    private var timer: Timer!
    private var angle: CGFloat = 0.0
    private let initialManager = InitialManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(preparationsDone), name: .preparationsDone, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(preparationsFail), name: .preparationsFail, object: nil)
        
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
        
        self.loadingLabel.text = NSLocalizedString("LOADING_LABEL", comment: "LOADING_LABEL")
    }
    
    @objc
    private func preparationsDone() {
            DispatchQueue.main.async {
                self.timer.invalidate()
                self.performSegue(withIdentifier: "start", sender: nil)
            }
    }
    
    @objc
    private func preparationsFail() {
        DispatchQueue.main.async {
            
            self.timer.invalidate()
            self.angle = 0.0
            let errors = self.initialManager.getErrors()
            let errorsCodes = errors.map{ ("\($0.code)") }.joined(separator: ",")
            let errorsDescriptions = errors.map{ $0.errorDescription }.joined(separator: "\n")
            let title = NSLocalizedString("ERROR_TITLE", comment: "ERROR_TITLE")
            
            let alert = UIAlertController(title: title + errorsCodes, message: errorsDescriptions, preferredStyle: .alert)
            let bttnTitle = NSLocalizedString("ERROR_RETRY", comment: "ERROR_RETRY")
            let alertAction = UIAlertAction(title: bttnTitle, style: .default, handler: self.retry(_:))
            alert.addAction(alertAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func retry(_: UIAlertAction) {
        self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
        self.initialManager.prepare()
    }
    
    @objc
    private func animation() {
        self.angle += 0.5
        UIView.animate(withDuration: 0.4) {
            self.spool.transform = CGAffineTransform(rotationAngle: self.angle)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initialManager.prepare()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .preparationsDone, object: nil)
        NotificationCenter.default.removeObserver(self, name: .preparationsFail, object: nil)
    }

}
