//
//  ActionViewController.swift
//  CustomTransitions
//
//  Created by Joyce Echessa on 3/2/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

final class ActionViewController: UIViewController {

    @IBAction private func dismissAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
