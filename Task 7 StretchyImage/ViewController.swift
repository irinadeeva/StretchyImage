//
//  ViewController.swift
//  Task 7 StretchyImage
//
//  Created by Irina Deeva on 20/11/24.
//

import UIKit

final class ViewController: UIViewController, UIScrollViewDelegate {
  let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height * 2)
    scrollView.automaticallyAdjustsScrollIndicatorInsets = false
    return scrollView
  }()

  let headerView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "DogImage")
    view.contentMode = .scaleToFill
    view.clipsToBounds = true
    return view
  }()

  var headerViewHeightConstraint: NSLayoutConstraint?
  var headerViewTopConstraint: NSLayoutConstraint?

  let headerViewMinHeight = 270.0
  let headerViewMaxHeight = UIScreen.main.bounds.size.height / 2

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
  }

  func setupView(){
    view.addSubview(scrollView)
    view.addSubview(headerView)

    scrollView.translatesAutoresizingMaskIntoConstraints = false
    headerView.translatesAutoresizingMaskIntoConstraints = false

    scrollView.delegate = self

    headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: headerViewMinHeight)
    headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: view.topAnchor)

    NSLayoutConstraint.activate([
      headerViewTopConstraint!,
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
      headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
      headerViewHeightConstraint!,

      scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let swipingDown = offsetY < 0
    let swipingUp = offsetY > 0

    let current = headerViewHeightConstraint!.constant

    if swipingDown, scrollView.isDragging, scrollView.isTracking {
      headerViewHeightConstraint?.constant =  min(current + (-offsetY), headerViewMaxHeight)
    }

    if swipingUp {
      headerViewTopConstraint?.constant = -min(offsetY, headerViewMinHeight)
      headerViewHeightConstraint?.constant = headerViewMinHeight
    }
  }

  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let isExpanded = headerViewHeightConstraint!.constant > headerViewMinHeight

    if isExpanded {
      UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
        self.headerViewHeightConstraint?.constant = self.headerViewMinHeight
        self.headerViewTopConstraint?.constant = 0
        self.view.layoutIfNeeded()
      }, completion: nil)
    }
  }
}
