package com.acessobio_flutter

import android.Manifest
import android.content.pm.PackageManager
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import com.acesso.acessobio_android.AcessoBio
import com.acesso.acessobio_android.iAcessoBioLiveness
import com.acesso.acessobio_android.services.dto.ErrorBio
import com.acesso.acessobio_android.services.dto.ResultLivenessX
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(), iAcessoBioLiveness {

    private lateinit var acessoBio: AcessoBio
    private lateinit var methodChannel: MethodChannel
    private lateinit var cameraResult: MethodChannel.Result

    companion object{
        const val CHANNEL = "id.acessodigital.native_communication.channel"
        const val KEY_NATIVE_LIVENESSX = "showNativeLivenessX"
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        initChennel()
        initAcessoBio()
        initMethodHandler()

    }

    private fun initChennel() {
        methodChannel = MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL)
    }

    private fun initAcessoBio() {
        acessoBio = AcessoBio(
                this,
                "url",
                "apikey",
                "token"
        )
    }

    private fun initMethodHandler(){

        try{

            methodChannel.setMethodCallHandler{ call, result ->

                if (call.method == KEY_NATIVE_LIVENESSX) {
                    openLiveness()
                }

                cameraResult = result

            }

        }catch (e: Exception ){
            cameraResult.success(-1)
        }

    }

    private fun openLiveness(){
        acessoBio.openLiveness()
    }

    override fun onSuccessLiveness(result: ResultLivenessX?) {
        cameraResult.success(result!!.base64)
    }

    override fun onErrorLiveness(result: ErrorBio?) {
        cameraResult.success(-1)
    }


    //region Camera Permission

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        if(requestCode != 10) {
            Toast.makeText(this, "Permissão acesso camera negada", Toast.LENGTH_SHORT).show()
        }
    }

    private fun getPermission() = arrayOf(Manifest.permission.CAMERA).all{
        ContextCompat.checkSelfPermission(this, it) == PackageManager.PERMISSION_GRANTED
    }

    override fun onResume() {
        super.onResume()
        if (!getPermission()) {
            requestPermissions(
                    arrayOf(Manifest.permission.CAMERA),
                    10
            )
        }
    }

    //endregion

}
