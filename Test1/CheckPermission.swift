import Foundation
import Photos

class CheckPermission{
    
    //ユーザーに許可を促す
    func checkCamera(){
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            case .authorized:
                print("authorized")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .limited:
                print("limited")
            @unknown default:
                break
            }
        }
    
    }
    
}

