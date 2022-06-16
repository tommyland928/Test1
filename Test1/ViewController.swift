import UIKit
// 1 WebKit の import
import WebKit
import AVFoundation
import MediaPlayer
import Foundation
import Photos
import NotificationCenter

class ViewController: UIViewController,AVCaptureFileOutputRecordingDelegate {
    private let captureSession = AVCaptureSession()
    private let fileOutput = AVCaptureMovieFileOutput()
    private var recordButton: UIButton!
    
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.allowsBackForwardNavigationGestures = true
        view.backgroundColor = .white
        
        // 7 URLオブジェクトを生成
        let myURL = URL(string:"https://www.twitter.com")
        // 8 URLRequestオブジェクトを生成
        let myRequest = URLRequest(url: myURL!)
        
        // 9 URLを WebView にロード
        webView.load(myRequest)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.setUpCamera()
        }
        
        
    }



    // デバイスの設定
    private func setUpCamera() {

        // デバイスの初期化
        let videoDevice: AVCaptureDevice? = AVCaptureDevice.default(for: AVMediaType.video)
        let audioDevice: AVCaptureDevice? = AVCaptureDevice.default(for: AVMediaType.audio)

        //ビデオの画質
        captureSession.sessionPreset = AVCaptureSession.Preset.hd4K3840x2160

        // ビデオのインプット設定
        let videoInput: AVCaptureDeviceInput = try! AVCaptureDeviceInput(device: videoDevice!)
        captureSession.addInput(videoInput)

        // 音声のインプット設定
        let audioInput = try! AVCaptureDeviceInput(device: audioDevice!)
        captureSession.addInput(audioInput)
        captureSession.addOutput(fileOutput)
        captureSession.startRunning()

        // ビデオ表示
//        let videoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        videoLayer.frame = self.view.bounds
//        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //self.view.layer.addSublayer(videoLayer)

        // 録画ボタン
//        self.recordButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
//        self.recordButton.backgroundColor = .white
//        self.recordButton.alpha = 0.02
//        self.recordButton.layer.masksToBounds = true
//        self.recordButton.layer.cornerRadius = 80 / 2
//        self.recordButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y:self.view.bounds.height - 120)
        
        self.recordButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        self.recordButton.backgroundColor = .white
        self.recordButton.alpha = 0.02
        self.recordButton.layer.masksToBounds = true
        self.recordButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y:self.view.bounds.height - 200)
        
        self.recordButton.addTarget(self, action: #selector(self.tappedRecordButton(sender:)), for: .touchUpInside)
        self.view.addSubview(recordButton)
    }
    
    
    @objc private func tappedRecordButton(sender: UIButton) {
        webView.reload()
        
        if self.fileOutput.isRecording {
            // 録画終了
            fileOutput.stopRecording()

            self.recordButton.backgroundColor = .white
        } else {
            // 録画開始
            let tempDirectory: URL = URL(fileURLWithPath: NSTemporaryDirectory())
            let fileURL: URL = tempDirectory.appendingPathComponent("sampletemp.mov")
            fileOutput.startRecording(to: fileURL, recordingDelegate: self)

            //self.recordButton.backgroundColor = .red
        }
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        // ライブラリへの保存
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputFileURL)
            }) { completed, error in
                if completed {
                    print("Video is saved!")
                }
            }
    }
    
    
}

// MARK: - 10 WKWebView ui delegate
extension ViewController: WKUIDelegate {
    // delegate
}

// MARK: - 11 WKWebView WKNavigation delegate
extension ViewController: WKNavigationDelegate {
    // delegate
}

