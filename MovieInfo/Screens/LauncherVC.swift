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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(preparationsDone), name: .preparationsDone, object: nil)
        self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
        
        self.loadingLabel.text = NSLocalizedString("LOADING_LABEL", comment: "LOADING_LABEL")
    }
    
    @objc
    private func animation() {
        self.angle += 0.5
        UIView.animate(withDuration: 0.4) {
            self.spool.transform = CGAffineTransform(rotationAngle: self.angle)
        }
    }
    
    @objc
    private func preparationsDone() {
            DispatchQueue.main.async {
                self.timer.invalidate()
                self.performSegue(withIdentifier: "start", sender: nil)
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let initialManager = InitialManager()
        initialManager.prepare()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .preparationsDone, object: nil)
    }

}
