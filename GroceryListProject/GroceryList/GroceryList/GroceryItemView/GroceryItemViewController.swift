//
//  GroceryItemViewController.swift
//  GroceryList
//
//  Created by Jezreel Barbosa on 28/02/21.
//

import UIKit
import Presentation

public protocol GroceryItemPresenting {

    var errorMessageBox: Box<String> { get }
    var groceryItemBox: Box<GroceryItemUpdateRequest> { get }

    func updateGroceryItem(item: GroceryItemUpdateRequest, successCompletion: () -> Void)
}

public class GroceryItemViewController: UICodeViewController<GroceryItemPresenting> {

    // Properties

    private lazy var mainView = GroceryItemView()

    // Override

    public override func loadView() {
        self.view = mainView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupPresenter()
    }

    // Functions

    private func setupView() {
        mainView.itemNameTextField.becomeFirstResponder()

        navigationItem.title = Resources.Texts.itemNavigationTitle
        navigationController?.navigationBar.prefersLargeTitles = false

        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonAction))
        navigationItem.rightBarButtonItem = saveBarButton
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBarButtonAction))
        navigationItem.leftBarButtonItem = cancelBarButton
    }

    private func setupPresenter() {
        presenter.errorMessageBox.bind { [unowned self] value in
            let title = LocalizedString().enUS("Attention").ptBR("Atenção").localizedText
            self.presentAlert(title: title, message: value)
        }

        presenter.groceryItemBox.bindAndFire { [unowned self] value in
            self.mainView.setItem(item: value)
        }
    }

    // Actions

    @objc private func saveBarButtonAction() {
        presenter.updateGroceryItem(item: mainView.getItem()) {
            dismiss(animated: true, completion: nil)
        }
    }

    @objc private func cancelBarButtonAction() {
        dismiss(animated: true, completion: nil)
    }
}
