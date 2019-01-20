//
//  ViewController.swift
//  NGSimpleDIExample
//
//  Created by Noah Gilmore on 1/20/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // HERE
        let service: CatServiceInterface = CatService()
        service.getCatImage(width: 300, height: 400, completion: { result in
            switch result {
            case let .error(error):
                print(error)
            case let .success(image):
                self.imageView.image = image
            }
        })
    }

}

