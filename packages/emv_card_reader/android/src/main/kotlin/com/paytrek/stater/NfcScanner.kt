package com.paytrek.stater

import android.nfc.NfcAdapter
import android.nfc.Tag
import android.nfc.tech.IsoDep
import android.os.Handler
import android.os.Looper
import com.github.devnied.emvnfccard.parser.EmvTemplate
import com.github.devnied.emvnfccard.model.enums.CardStateEnum
import java.io.IOException
import java.text.SimpleDateFormat

class NfcScanner(private val plugin: EmvCardReaderPlugin) : NfcAdapter.ReaderCallback {
    private val handler = Handler(Looper.getMainLooper())

    override fun onTagDiscovered(tag: Tag) {
        val sink = plugin.sink ?: return

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
                sink.success(res)
            }

        } catch (e: Exception) {
            handler.post {
                sink.error("PLUGIN_ERROR", "${e.localizedMessage}",null)
            }
        }
    }
}
