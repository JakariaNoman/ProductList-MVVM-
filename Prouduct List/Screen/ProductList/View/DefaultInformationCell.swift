//
//  DefaultInformationTableViewCell.swift
//  Prouduct List
//
//  Created by Jakaria Noman on 11/1/25.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

enum CellState {
    case showIndicator
    case showRefreshButton
}

class DefaultInformationCell: UITableViewCell {
    
    @IBOutlet weak var activityIndication: UIActivityIndicatorView!
    @IBOutlet weak var refreshedButton: UIButton!
    var productModel = ProductViewModel()
    var dataStartFetch : CellState = .showIndicator {
        didSet {
            handleInditacorAndRefreshedButton(for: dataStartFetch)
        }
    }
    
    @IBAction func refreshedButtonTapped(_ sender: Any) {
        
        guard let viewController = self.parentViewController else { return }
        
        let alertController = UIAlertController(
            title: nil,
            message: "Data are fetchecd. Thanks",
            preferredStyle: .alert)
        let okButton = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: nil)
        alertController.addAction(okButton)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func handleInditacorAndRefreshedButton(for state : CellState) {
        switch state {
        case .showIndicator:
            activityIndication.startAnimating()
            activityIndication.isHidden = false
            refreshedButton.isHidden = true
        case .showRefreshButton:
            activityIndication.stopAnimating()
            activityIndication.isHidden = true
            refreshedButton.isHidden = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
