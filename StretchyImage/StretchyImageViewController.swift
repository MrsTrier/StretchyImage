//
//  ViewController.swift
//  StretchyImage
//
//  Created by Daria Cheremina on 20/11/2024.
//

import UIKit

enum Constants: CGFloat {
    case maxImageViewHeight = 500
    case baseImageViewHeight = 270
}

class StretchyImageViewController: UIViewController {
    private var imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "HD-wallpaper-ios-14-ipad-iphone-thumbnail"))
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false

        return iv
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height * 2)
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var heightConstraint: NSLayoutConstraint = imageView.heightAnchor.constraint(equalToConstant: Constants.baseImageViewHeight.rawValue)
    private lazy var topConstraint: NSLayoutConstraint = imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setUpImageView()
        setUpScrollView()
    }

    func setUpImageView() {
        view.addSubview(imageView)
        heightConstraint = imageView.heightAnchor.constraint(equalToConstant: Constants.baseImageViewHeight.rawValue)
        topConstraint = imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)

        NSLayoutConstraint.activate([
            topConstraint,
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightConstraint
        ])
    }

    func setUpScrollView() {
        scrollView.delegate = self
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension StretchyImageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset < 0 {
            self.heightConstraint.constant = min(500, (self.heightConstraint.constant) - offset)
        } else {
            self.topConstraint.constant = -min(Constants.baseImageViewHeight.rawValue, offset)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.heightConstraint.constant > Constants.baseImageViewHeight.rawValue {
            animateHeader()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.heightConstraint.constant > Constants.baseImageViewHeight.rawValue {
            animateHeader()
        }
    }
    func animateHeader() {
        self.heightConstraint.constant = Constants.baseImageViewHeight.rawValue
        self.topConstraint.constant = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
