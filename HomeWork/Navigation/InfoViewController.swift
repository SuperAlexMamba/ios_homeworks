//
//  InfoViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 20.12.2022.
//

import UIKit

class InfoViewController: UIViewController {

    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("push_post_button_key", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.backgroundColor = .gray
        return button
    }()
    
    lazy var serializationLabel = UILabel()
    lazy var decodeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        
        NetworkSerialization.request { title in
            DispatchQueue.main.async {
                self.serializationLabel.text = title
            }
        }
        
        NetworkServiceWitchDecoder.request { period in
            DispatchQueue.main.async {
                self.decodeLabel.text = period
            }
        }
        
        title = NSLocalizedString("info_button_key", comment: "")
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(serializationLabel)
        view.addSubview(decodeLabel)
        setupConstraints()
    }
    
    @objc private func buttonAction(){
        presentAlert()
    }
    
    private func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        button.translatesAutoresizingMaskIntoConstraints = false
        serializationLabel.translatesAutoresizingMaskIntoConstraints = false
        serializationLabel.textAlignment = .center
        decodeLabel.translatesAutoresizingMaskIntoConstraints = false
        decodeLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            
            button.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 165),
            button.heightAnchor.constraint(equalToConstant: 95),
            
            serializationLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            serializationLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -200),
            serializationLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 1),
            serializationLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -1),
            serializationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            decodeLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            decodeLabel.topAnchor.constraint(equalTo: serializationLabel.bottomAnchor, constant: 35),
            decodeLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 1),
            decodeLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -1),
            decodeLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    private func presentAlert() {
        
        let alert = UIAlertController(title: NSLocalizedString("success_key", comment: ""), message: NSLocalizedString("alert_post_message_key", comment: ""), preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        let printAction = UIAlertAction(title: NSLocalizedString("console_print_key", comment: ""), style: .default) { _ in
            print("NETOLOGY!!!")
        }
        
        alert.addAction(cancelAction)
        alert.addAction(printAction)
        
        present(alert, animated: true)
        
    }
}
