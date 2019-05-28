//
//  ViewController.swift
//  PrenticeBrothers
//
//  Created by Rachel Wilson on 5/25/19.
//  Copyright © 2019 Dylan Anderson. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {

    @IBOutlet weak var slideSlowCollectionView: UICollectionView!
    
    #warning("Welcome label is different colors based on the slide show")
    
    var imgArr = [  UIImage(named:"image0"),
                    UIImage(named:"image1"),
                    UIImage(named:"image2"),
                    UIImage(named:"image3") ]
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1.0)
        slideSlowCollectionView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1.0)
        
        addAllButtons()
        profilePictureAndMessages()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func profilePictureAndMessages() {
        let myProfilePicture = UIButton(frame: CGRect(x: view.frame.midX/12, y: view.frame.minY + view.frame.midX/4.5, width: view.frame.width/7, height: view.frame.width/7))
        myProfilePicture.setImage(UIImage(named: "user"), for: .normal)
        myProfilePicture.clipsToBounds = true
        myProfilePicture.adjustsImageSizeForAccessibilityContentSizeCategory = false
        myProfilePicture.layer.backgroundColor = UIColor.black.cgColor
        myProfilePicture.layer.cornerRadius = myProfilePicture.frame.width/2
        myProfilePicture.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        view.addSubview(myProfilePicture)
        
        let myMessages = UIButton(frame: CGRect(x: view.frame.maxX - view.frame.midX/3, y: view.frame.minY + view.frame.midX/4.5, width: view.frame.width/7, height: view.frame.width/7))
        myMessages.setImage(UIImage(named: "message"), for: .normal)
        myMessages.adjustsImageSizeForAccessibilityContentSizeCategory = false
        myMessages.addTarget(self, action: #selector(goToMessages), for: .touchUpInside)
        view.addSubview(myMessages)
        
        let welcomeLabel = UILabel(frame: CGRect(x: view.frame.midX/2, y: view.frame.minY + view.frame.midX/4.5, width: view.frame.width/2, height: 70))
        #warning("Add the users name(10 is max length) below from core data")
        welcomeLabel.text = "Welcome, Donovan"
        welcomeLabel.adjustsFontSizeToFitWidth = true
        welcomeLabel.numberOfLines = 2
        welcomeLabel.font = UIFont(name: "Marker Felt", size: 50)
        welcomeLabel.adjustsFontForContentSizeCategory = true
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .center
        view.addSubview(welcomeLabel)
    }
    
    func addAllButtons() {
        let bookingsButton = UIButton(frame: CGRect(x: view.frame.midX - view.frame.width/3 - 20 , y: view.frame.midY + view.frame.midY/2, width: view.frame.width/3, height: view.frame.width/7))
        bookingsButton.setTitle("Book now", for: .normal)
        bookingsButton.layer.cornerRadius = 15
        bookingsButton.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        bookingsButton.addTarget(self, action: #selector(goTobookViewController), for: .touchUpInside)
        view.addSubview(bookingsButton)
        
        let directionsButton = UIButton(frame: CGRect(x: view.frame.midX + 20, y: view.frame.midY + view.frame.midY/2, width: view.frame.width/3, height: view.frame.width/7))
        directionsButton.setTitle("Directions", for: .normal)
        directionsButton.layer.cornerRadius = 15
        directionsButton.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        directionsButton.addTarget(self, action: #selector(goToDirectionsViewController), for: .touchUpInside)
        view.addSubview(directionsButton)
        
        let loyaltyButton = UIButton(frame: CGRect(x: view.frame.midX - view.frame.width/3 - 20, y: view.frame.maxY - view.frame.height/3.5 + view.frame.width/4, width: view.frame.width/3, height: view.frame.width/7))
        loyaltyButton.setTitle("Rewards", for: .normal)
        loyaltyButton.layer.cornerRadius = 15
        loyaltyButton.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        loyaltyButton.addTarget(self, action: #selector(goToLoyaltyViewController), for: .touchUpInside)
        view.addSubview(loyaltyButton)
        
        let socialMediaButton = UIButton(frame: CGRect(x: view.frame.midX + 20, y: view.frame.maxY - view.frame.height/3.5 + view.frame.width/4, width: view.frame.width/3, height: view.frame.width/7))
        socialMediaButton.setTitle("Social Media", for: .normal)
        socialMediaButton.layer.cornerRadius = 15
        socialMediaButton.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        socialMediaButton.addTarget(self, action: #selector(goToSocialMediaViewController), for: .touchUpInside)
        view.addSubview(socialMediaButton)
    }
    
    @objc func goTobookViewController(sender: UIButton) {
        sender.pulsate()
        if let vc = UIStoryboard(name: "Book", bundle: nil).instantiateViewController(withIdentifier: "bookVC") as? BookController {
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func goToDirectionsViewController(sender: UIButton) {
        sender.pulsate()
        if let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "locationVC") as? LocationController {
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func goToLoyaltyViewController(sender: UIButton) {
        sender.pulsate()
        if let vc = UIStoryboard(name: "Loyalty", bundle: nil).instantiateViewController(withIdentifier: "loyaltyVC") as? LoyaltyController {
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func goToSocialMediaViewController(sender: UIButton) {
        sender.pulsate()
        if let vc = UIStoryboard(name: "SocialMedia", bundle: nil).instantiateViewController(withIdentifier: "socialVC") as? SocialMediaController {
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func goToMessages() {
        print("Go to my messages")
    }
    
    @objc func goToProfile() {
        print("Go to my profile")
    }

    @objc func changeImage() {
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.slideSlowCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.slideSlowCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            counter = 1
        }
        
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(1) as? UIImageView {
            vc.image = imgArr[indexPath.row]
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = slideSlowCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
