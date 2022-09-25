
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var player = AVAudioPlayer()
    private var index = 0
    private var trackList: [String] = ["Queen", "BobDylan", "JoanOsborne", "SpiceGirls", "TheBeloved"]
    
    private let slider = UISlider()
    private var timer: Timer?
    
    private let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBAction func recordAudioButtonTapped(_ sender: Any) {

        let vc = RecorderViewController()
        self.present(vc, animated: true) {
            self.stopButton(self)
        }


    }
    @IBAction func ShowVideoButtonAction(_ sender: Any) {


        let vc = VideoViewController()
        self.present(vc, animated: true) {
            self.stopButton(self)
        }



    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        playTrack(track: trackList[index])
    }
    
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        if index < trackList.count - 1 {
            index += 1
        } else {
            index = 0
        }
        playTrack(track: trackList[index])
    }
    
    
    
    @IBAction func backwardButtonAction(_ sender: Any) {
        if index > 0 {
            index -= 1
        } else {
            index = trackList.count - 1
        }
        playTrack(track: trackList[index])
    }
    
    @IBAction func playPauseButton(_ sender: Any) {
        if player.isPlaying {
            player.pause()
            playPauseButton.setImage(UIImage(systemName: "play.fill", withConfiguration: largeConfig), for: .normal)
        } else {
            player.play()
            playPauseButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: largeConfig), for: .normal)
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        if player.isPlaying {
            player.stop()
            playPauseButton.setImage(UIImage(systemName: "play.fill", withConfiguration: largeConfig), for: .normal)
        }
        else {
            print("Already stopped!")
        }
        player.currentTime = 0
    }
    
    
    private func setupView() {
        self.slider.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40 , height: 30)
        self.slider.center = self.view.center
        self.slider.minimumValue = 0.0
        self.view.addSubview(slider)
        self.slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        
        playPauseButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: largeConfig), for: .normal)
        stopButton.setImage(UIImage(systemName: "stop.fill", withConfiguration: largeConfig), for: .normal)
        backwardButton.setImage(UIImage(systemName: "backward.fill", withConfiguration: largeConfig), for: .normal)
        forwardButton.setImage(UIImage(systemName: "forward.fill", withConfiguration: largeConfig), for: .normal)
    }
    
    private func setTimer () {
        
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
                [self] _ in
                self.slider.setValue(Float(self.player.currentTime), animated: true)
            }
        }
    }
    
    
    @objc func changeSlider(sender: UISlider) {
        
        if sender == slider {
            self.player.currentTime = TimeInterval(sender.value)
        }
    }
    
    
    func playTrack (track: String) {
        
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: track, ofType: "mp3")!))
            trackName.text = track
            self.slider.maximumValue = Float(player.duration)
            setTimer()
            player.delegate = self
            player.prepareToPlay()
            player.play()
            playPauseButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: largeConfig), for: .normal)
            
        }
        catch {
            print(error)
        }
    }
}


extension ViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        if index < trackList.count - 1 {
            index += 1
        } else {
            index = 0
        }
        playTrack(track: trackList[index])
    }
}
