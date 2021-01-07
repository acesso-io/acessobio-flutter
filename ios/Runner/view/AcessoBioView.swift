//
//  AcessoBioView.swift
//  Runner
//
//  Created by Lucas Diniz Silva on 04/01/21.
//

import UIKit
import Flutter

class AcessoBioView: UIViewController, AcessoBioDelegate {
        
    var isOpenCamera: Bool =  false
    var result: FlutterResult!
    var acessoBioManager: AcessoBioManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAcessoBio()
        initLiviness()
        
        self.view.backgroundColor = UIColor.white;
    }
    
    private func initAcessoBio(){
        acessoBioManager = AcessoBioManager(
            viewController: self,
            url: "url",
            apikey: "apikey",
            token:"token"
        );
    }
    
    private func initLiviness(){
        isOpenCamera = true
        acessoBioManager.openLivenessX();
    }
    
    func onSuccesLivenessX(_ result: LivenessXResult!) {
        let base64 = result.base64;
        self.result(base64);
    }
    
    func onSuccesCameraFace(_ result: CameraFaceResult!) {
        let base64 = result.base64;
        self.result(base64);
    }
    
    func onErrorLivenessX(_ error: String!) {
        NSLog("%@", error);
        self.result(-1);
    }
    
    func onErrorCameraFace(_ error: String!) {
        NSLog("%@", error);
        self.result(-1);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(isOpenCamera){
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
