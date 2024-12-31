package com.paytrek.stater

import android.app.Activity
import android.nfc.NfcAdapter
import android.nfc.Tag
import android.nfc.tech.IsoDep
import android.os.Handler
import android.os.Looper
import com.github.devnied.emvnfccard.parser.EmvTemplate
import com.github.devnied.emvnfccard.model.enums.CardStateEnum
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import java.text.SimpleDateFormat

sealed class AbstractNfcHandler(val result: MethodChannel.Result, val call: MethodCall) : NfcAdapter.ReaderCallback {
    protected fun unregister() = EmvCardReaderPlugin.listeners.remove(this)
}

class NfcReader(result: MethodChannel.Result, call: MethodCall) : AbstractNfcHandler(result, call) {
    private val handler = Handler(Looper.getMainLooper())

    override fun onTagDiscovered(tag: Tag) {
        try {
            var id: IsoDep = IsoDep.get(tag)
            id.connect()

            val provider = IsoDepProvider(id)
            val config = EmvTemplate.Config()
            val parser = EmvTemplate.Builder().setProvider(provider).setConfig(config).build()
            val card = parser.readEmvCard()

            var firstName = card.getHolderFirstname();
            var lastName = card.getHolderLastname();
            var fullName : String? = null
            if (firstName != null && lastName != null) {
                fullName = firstName + " " + lastName
            } else if (firstName != null){
                fullName = firstName;
            } else if (lastName != null){
                fullName = lastName;
            }

            val fmt = SimpleDateFormat("MM/YY")
            val expire = fmt.format(card.getExpireDate());

            val status = when (card.getState()) {
                CardStateEnum.UNKNOWN -> "UNKNOWN"
                CardStateEnum.LOCKED -> "LOCKED"
                CardStateEnum.ACTIVE -> "ACTIVE"
                else -> "UNKNOWN"
            }

            val res = HashMap<String, String?>()
            res.put("type", card.getType().getName())
            res.put("number", card.getCardNumber())
            res.put("expire", expire)
            res.put("holder", fullName)
            res.put("status", status)

            id.close()
            handler.post{
                result.success(res)
            }

        } catch (e: Exception) {
            handler.post {
                result.error("PLUGIN_ERROR", "${e.localizedMessage}",null)
            }
        }
        unregister()
    }
}