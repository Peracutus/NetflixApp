//
//  PreviewViewController.swift
//  NetflixApp
//
//  Created by Roman on 31.10.2022.
//

import Foundation
import WebKit
import EasyPeasy

final class PreviewViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 33, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "TITLE"
        return title
    }()
    
    private let overviewLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 28, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.text = "Preview"
        return title
    }()
    
    private let dwnldBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .red
        btn.setTitle("Download", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        return btn
    }()
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupView()
    }
    
    private func setupView() {
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(dwnldBtn)
        webView.easy.layout(Left(), Right(), Top().to(view.safeAreaLayoutGuide, .top), Height(300))
        titleLabel.easy.layout(Left(20), Top(20).to(webView))
        overviewLabel.easy.layout(Left(20), Top(15).to(titleLabel), Right(20))
        dwnldBtn.easy.layout(CenterX(), Top(25).to(overviewLabel), Height(40), Width(140))
    }
    
    func configure(with model: TitlePreviewVM) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOvierview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else { return }
        webView.load(URLRequest(url: url))
    }
}
