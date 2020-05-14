//
//  ViewController.swift
//  ContactsMVVM-Swift
//
//  Created by Tássio Marcos Rocha on 14/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

private struct Const {
    /// Buttom height/width for Large NavBar state
    static let ButtomSizeForLargeState: CGFloat = 40
    /// Margin from right anchor of safe area to right anchor of Buttom
    static let ButtomRightMargin: CGFloat = 16
    /// Margin from bottom anchor of NavBar to bottom anchor of Buttom for Large NavBar state
    static let ButtomBottomMarginForLargeState: CGFloat = 12
    /// Margin from bottom anchor of NavBar to bottom anchor of Buttom for Small NavBar state
    static let ButtomBottomMarginForSmallState: CGFloat = 6
    /// Buttom height/width for Small NavBar state
    static let ButtomSizeForSmallState: CGFloat = 32
    /// Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}

class ViewController: UIViewController, Storyboarded,UITableViewDelegate, UITableViewDataSource {
    
    weak var coodinator: MainCoordinator?
    @IBOutlet weak var tableView: UITableView!
    var contacts = [Contact]()
    var realm: Realm?
    
    private let button: UIButton = UIButton(type: .contactAdd)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getContacts()
        self.setupUI()

        do {
            self.realm = try Realm()
        } catch let error  as NSError {
            print(error)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else {
            return
        }
        
        moveAndRedizeButtom(for: height);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupUI();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:            IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell");
        cell.textLabel?.text = self.contacts[indexPath.row].name;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.deleteContact(index: indexPath.row)
    }
    
    func deleteContact(index: Int) {
        let real = try! Realm();
        
        let contact: Contact = self.contacts[index]
        
        try! realm?.write {
            real.delete(contact)
            self.contacts.remove(at: index);
            self.getContacts();
        }
    }
    
    func getContacts () {
        let realm = try! Realm()
        let contacts = realm.objects(Contact.self)
        
        for contact in contacts {
            print(contact)
            self.contacts.append(contact)
        }
        self.tableView.reloadData();
    }
    
    @objc func goToCreateContact() {
        coodinator?.changeOrCreateContact();
    }
}


extension ViewController {
    func setupUI () {
        navigationController?.navigationBar.prefersLargeTitles = true;
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        button.tag = 200;
        navigationBar.addSubview(button);
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.goToCreateContact), for: .touchUpInside)
    
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ButtomRightMargin),
            button.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ButtomBottomMarginForLargeState),
            button.heightAnchor.constraint(equalToConstant: Const.ButtomSizeForLargeState),
            button.widthAnchor.constraint(equalTo: button.heightAnchor)
        ])
    }
    
    func moveAndRedizeButtom(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenState = (Const.NavBarHeightLargeState - Const.ButtomBottomMarginForSmallState)
            
            return delta / heightDifferenceBetweenState
        }()
        
        let factor = Const.ButtomSizeForSmallState / Const.ButtomSizeForLargeState
        
        let scale : CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        let sizeDiff = Const.ButtomSizeForLargeState * (1.0 - factor);
        
        let yTranslation : CGFloat = {
            let maxYTranslation = Const.ButtomBottomMarginForLargeState - Const.ButtomBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ButtomBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff);
        
        button.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale).translatedBy(x: xTranslation, y: yTranslation)
    }
    
}
