//
//  UsersViewController.swift
//  CleanSwiftSample
//
//  Created by Bhatia, Parveen on 03/20/18 Bhatia.
//  Copyright (c) 2018 Bhatia, Parveen. All rights reserved.


import UIKit

protocol UsersDisplayLogic: class
{
    func displayUserList(viewModel: Users.ViewModel)
    func displayError(with message: String)
}

class UsersViewController: UIViewController, UsersDisplayLogic, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var usersTableView: UITableView!
    var interactor: UsersBusinessLogic?
    var router: (NSObjectProtocol & UsersRoutingLogic)?
    var displayUsers = [Users.ViewModel.DisplayUser]()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = UsersInteractor()
        let presenter = UsersPresenter()
        let router = UsersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        usersTableView.register(UINib.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCellId")
        self.title = "Users"
        loadUsers()
    }
    
    // MARK: loadUsers
    
    func loadUsers()
    {
        let request = Users.Request()
        self.interactor?.loadUsers(request: request)
    }
    
    // MARK: TableView delegate methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let userCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCellId") as? UserTableViewCell
        {
            let userDetail = displayUsers[indexPath.row]
            userCell.userNameLabel.text = userDetail.fullName
            userCell.streetAndSuiteLabel.text = userDetail.addressLine1
            userCell.cityDetailsLabel.text = userDetail.addressLine2
            return userCell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return displayUsers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        router?.navigateUserPost(with: displayUsers[indexPath.row])
    }
    
    // MARK: UserDisplay Logic
    
    func displayUserList(viewModel: Users.ViewModel)
    {
        displayUsers = viewModel.displayedUsers
        usersTableView.reloadData()
    }
    
    func displayError(with message: String)
    {
        let alert = UIAlertController(title: "Load Users - Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
