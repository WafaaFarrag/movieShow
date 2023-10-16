//
//  HomeViewController.swift
//  VideoShow
//
//  Created by Wafaa Farag on 16/10/2023.
//

import UIKit
import AVKit
import Moya
import Player

class HomeViewController: BaseStatefulViewController<HomeViewModel>   {
    @IBOutlet weak var vedioView: UIView!
    
    var player = Player()
    
    deinit {
        self.player.willMove(toParent: nil)
        self.player.view.removeFromSuperview()
        self.player.removeFromParent()
    }
    
    override func viewDidLoad() {
        
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        
        let provider = MoyaProvider<BaseAPI>(plugins: [plugin])
        
        viewModel = HomeViewModel(api: provider)
        super.viewDidLoad()
        viewModel.getAllMyDocumentsRequest()
        setupBinding()
        createUi()
    }
    
    @objc func nextButtonTapped() {
        player.stop()
        let video = viewModel.getNextVideo()
        if let videoURL = video,let videoURL = URL(string: videoURL) {
            player.url = videoURL
            player.playFromBeginning()
        }
        
    }
    
    @objc func previousButtonTapped() {
        player.stop()
        let video = viewModel.getPreviousVideo()
        if let videoURL = video,let videoURL = URL(string: videoURL) {
            player.url = videoURL
            player.playFromBeginning()
        }
    }
    
    private func createUi() {
        
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        player.playerDelegate = self
        player.playbackDelegate = self
        
        player.playerView.playerBackgroundColor = .clear
        
        addChild(player)
        player.view.translatesAutoresizingMaskIntoConstraints = false
        vedioView.addSubview(player.view)
        
        NSLayoutConstraint.activate([
            player.view.topAnchor.constraint(equalTo: vedioView.topAnchor),
            player.view.leadingAnchor.constraint(equalTo: vedioView.leadingAnchor),
            player.view.trailingAnchor.constraint(equalTo: vedioView.trailingAnchor),
            player.view.bottomAnchor.constraint(equalTo: vedioView.bottomAnchor)
        ])
        
        let nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        let previousButton = UIButton()
        previousButton.setTitle("Previous", for: .normal)
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        
        vedioView.addSubview(nextButton)
        vedioView.addSubview(previousButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: vedioView.topAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: vedioView.trailingAnchor, constant: -16),
            
            previousButton.topAnchor.constraint(equalTo: vedioView.topAnchor, constant: 16),
            previousButton.leadingAnchor.constraint(equalTo: vedioView.leadingAnchor, constant: 16)
        ])
        
        player.didMove(toParent: self)
        player.playbackLoops = true
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupBinding() {
        viewModel.responseOfGetAllVedios.subscribe(onNext: { [weak self] videoURL in
            guard let self = self else {return}
            if let videoURL = videoURL,let videoURL = URL(string: videoURL[0]) {
                self.player.url = videoURL
                player.playFromBeginning()
            }
        }).disposed(by: disposeBag)
    }
    
}




// MARK: - UIGestureRecognizer

extension HomeViewController {
    
    @objc func handleTapGestureRecognizer(_ gestureRecognizer: UITapGestureRecognizer) {
        switch self.player.playbackState {
        case .stopped:
            self.player.playFromBeginning()
            break
        case .paused:
            self.player.playFromCurrentTime()
            break
        case .playing:
            self.player.pause()
            break
        case .failed:
            self.player.pause()
            break
        }
    }
    
}

// MARK: - PlayerDelegate

extension HomeViewController: PlayerDelegate {
    
    func playerReady(_ player: Player) {
        print("\(#function) ready")
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        print("\(#function) \(player.playbackState.description)")
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
    }
    
    func player(_ player: Player, didFailWithError error: Error?) {
        print("\(#function) error.description")
    }
    
}

// MARK: - PlayerPlaybackDelegate

extension HomeViewController: PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        
        
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
    }
    
    func playerPlaybackDidLoop(_ player: Player) {
    }
}
