//
//  CardsViewController.swift
//  Tinder
//
//  Created by Ka Lee on 10/15/18.
//  Copyright © 2018 Ka Lee. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    
    @IBOutlet weak var cardImageView: UIImageView!
    var cardInitialCenter: CGPoint!
    var divisor: CGFloat!
    var fadeTransition: FadeTransition!

    
    @IBAction func didPanCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let location = sender.location(in: view)

        let imageView = sender.view as! UIImageView
        let xFromCenter = imageView.center.x - view.center.x
        
        imageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)

        if location.y < cardInitialCenter.y {
            imageView.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor)
        } else {
            imageView.transform = CGAffineTransform(rotationAngle: xFromCenter / -divisor)
        }
        
        
        if sender.state == .began {
            
        } else if sender.state == .changed {
            
        } else if sender.state == .ended {
            if imageView.center.x < cardInitialCenter.x - 50 {
                UIView.animate(withDuration: 0.3, animations: {
                    imageView.center = CGPoint(x: imageView.center.x - 500, y: imageView.center.y)
                    imageView.alpha = 0
                })
            } else if imageView.center.x > cardInitialCenter.x + 50 {
                UIView.animate(withDuration: 0.3, animations: {
                    imageView.center = CGPoint(x: imageView.center.x + 500, y: imageView.center.y)
                    imageView.alpha = 0
                })
            } else {
                imageView.center = cardInitialCenter
                imageView.transform = CGAffineTransform.identity
            }
            
        }
    }
    
    @objc func didTapCard(_ sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardInitialCenter = cardImageView.center
        divisor = (view.frame.width / 2) / 0.7
        let tapCard = UITapGestureRecognizer(target: self, action: #selector(didTapCard(_:)))
        cardImageView.isUserInteractionEnabled = true
        cardImageView.addGestureRecognizer(tapCard)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "profileSegue" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.modalPresentationStyle = UIModalPresentationStyle.custom
            fadeTransition = FadeTransition()
            profileVC.transitioningDelegate = fadeTransition
            fadeTransition.duration = 1.0
            profileVC.profileImage = cardImageView.image
        }
        
    }

}
