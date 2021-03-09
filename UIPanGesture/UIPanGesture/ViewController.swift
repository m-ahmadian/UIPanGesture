//
//  ViewController.swift
//  UIPanGesture
//
//  Created by Mehrdad on 2021-03-02.
//  Copyright © 2021 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    
    var fileViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addPanGesture(view: fileImageView)
        fileViewOrigin = fileImageView.frame.origin
        view.bringSubviewToFront(fileImageView)
    }

    // MARK: - Helper Methods
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        let translate = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            fileView.center = CGPoint(x: fileView.center.x + translate.x, y: fileView.center.y + translate.y)
            sender.setTranslation(CGPoint.zero, in: view)
            
        case .ended:
            if fileView.frame.intersects(trashImageView.frame) {
                UIView.animate(withDuration: 0.3) {
                    self.fileImageView.alpha = 0.0
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.fileImageView.frame.origin = self.fileViewOrigin
                }
            }
        default:
            break
        }
    }
    
}
