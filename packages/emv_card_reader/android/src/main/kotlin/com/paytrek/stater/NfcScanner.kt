package com.paytrek.stater

import android.nfc.NfcAdapter
import android.nfc.Tag
import android.nfc.tech.IsoDep
import android.os.Handler
import android.os.Looper
import com.github.devnied.emvnfccard.parser.EmvTemplate
import com.github.devnied.emvnfccard.model.enums.CardStateEnum
import com.github.devnied.emvnfccard.model.EmvCard
import java.io.IOException
import java.text.SimpleDateFormat

class NfcScanner(private val plugin: EmvCardReaderPlugin) : NfcAdapter.ReaderCallback {
    private val handler = Handler(Looper.getMainLooper())

    override fun onTagDiscovered(tag: Tag) {
        val sink = plugin.sink ?: return
        var id: IsoDep = IsoDep.get(tag)

        try {
            id.connect()

            val provider = IsoDepProvider(id)
            if (provider.getAt().isEmpty()) {
                handler.post {
                    sink.success(emptyCard())
                }
                return;
            }

            val config = EmvTemplate.Config()
            val parser = EmvTemplate.Builder().setProvider(provider).setConfig(config).build()
            val card = parser.readEmvCard()
            handler.post{
                sink.success(processCard(card))
            }
        } catch (e: Exception) {
            handler.post {
                sink.error("PLUGIN_ERROR", "${e.localizedMessage}",null)
            }
        } finally {
            id.close()
        }
    }
}

fun processCard(card: EmvCard?): HashMap<String, String?> {
    if (card == null) {
        return emptyCard();
    }

    try {
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
        val _expire = card.getExpireDate()
        val expire = if (_expire != null) fmt.format(_expire) else "N/A"

        val state = card.getState() ?: CardStateEnum.UNKNOWN;
        val status = when (state) {
            CardStateEnum.UNKNOWN -> "UNKNOWN"
            CardStateEnum.LOCKED -> "LOCKED"
            CardStateEnum.ACTIVE -> "ACTIVE"
            else -> "UNKNOWN"
        }

        val res = HashMap<String, String?>()
        res["type"] = card.getType()?.getName()
        res["number"] = card.getCardNumber()
        res["expire"] = expire
        res["holder"] = fullName
        res["status"] = status

        if (res["type"] == null || res["number"] == null) {
            return emptyCard();
        }
        return res

    } catch (e: Exception) {
        return emptyCard();
    }
    return emptyCard();
}

fun emptyCard(): HashMap<String, String?> {
    val res = HashMap<String, String?>()
    res["is_empty"] = "true"
    return res
}