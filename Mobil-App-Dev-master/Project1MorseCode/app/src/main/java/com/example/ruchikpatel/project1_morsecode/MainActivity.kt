package com.example.ruchikpatel.project1_morsecode

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioTrack
import android.os.Bundle
import android.support.design.widget.Snackbar
import android.support.v7.app.AppCompatActivity
import android.text.method.ScrollingMovementMethod
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.view.inputmethod.InputMethodManager
import android.preference.PreferenceManager.getDefaultSharedPreferences
import android.Manifest.permission_group.SMS
import com.ajts.unifiedsmslibrary.Callback.SMSCallback
import com.ajts.unifiedsmslibrary.SMS
import com.ajts.unifiedsmslibrary.Services.Twilio

import android.provider.Settings
import java.lang.Exception



import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.content_main.*
import org.json.JSONObject
import java.util.*
import kotlin.concurrent.timerTask
import okhttp3.Call
import okhttp3.Response

val SAMPLE_RATE = 44100

class MainActivity : AppCompatActivity() {


    val letToCodeDict : HashMap<String, String> = HashMap<String, String>()
    val codeToLetDict : HashMap<String, String> = HashMap<String, String>()

    var prefs: SharedPreferences? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(toolbar)

        prefs = getDefaultSharedPreferences(this.applicationContext)

        val morsePitch = prefs!!.getString("morse_pitch","550").toInt()

        fab.setOnClickListener { view ->
            val input = userInput.text.toString()

            appendTextAndScroll(input.toUpperCase())


            if (input.matches("(\\.|-|/|\\s)+".toRegex())) {
                val transMorse = translateMorse(input)
                 doTwilioSend(transMorse, "+1 914-671-4445")
                appendTextAndScroll(transMorse.toUpperCase())
            }
            else {
                val transText = translateText(input)
                doTwilioSend(transText, R.string.toNumber.toString())
                appendTextAndScroll(transText)
            }


            //Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                //    .setAction("Action", null).show()
        }
        //Scroll
        outText.movementMethod = ScrollingMovementMethod()

        // Hide keyboard
        translateBtn.setOnClickListener{ view ->
            appendTextAndScroll(userInput.text.toString())
            hideKeyboard()

        }

        // Calling functions when codes button is clicked
        val jsonObj = loadMorseJSONFile();
        buildDictsWithJSON(jsonObj)

        shwcodes.setOnClickListener{ _ ->
            outText.text = ""   // Empyting the text area if it's empty and than show codes
            showCodes()
            hideKeyboard()
        }


        translateBtn.setOnClickListener { _ ->
            outText.text = ""
            val input = userInput.text.toString()

            appendTextAndScroll(input.toUpperCase())

            // Regex for exclusive Morse Code: [\.-]{1,5}(?> [\.-]{1,5})*(?> / [\.-]{1,5}(?> [\.-]{1,5})*)*
            if (input.matches("(\\.|-|\\s/\\s|\\s)+".toRegex())) { //Old Regex: (\.|-|\s/\s|\s)+
                val transMorse = translateMorse(input)
                appendTextAndScroll(transMorse.toUpperCase())
            }
            else {
                val transText = translateText(input)
                appendTextAndScroll(transText)
            }
            hideKeyboard()
        }

        soundBtn.setOnClickListener { _ ->
            val input = userInput.text.toString()
            playString(translateText(input),0)
        }




    }

    // ======================================= CUSTOM CODE  =======================================>

    private fun appendTextAndScroll(text: String)
    {
        if (outText != null)
        {
            outText.append(text + "\n")
            val layout = outText.getLayout()
            if (layout != null)
            {
                val scrollDelta = (layout!!.getLineBottom(outText.getLineCount() - 1) - outText.getScrollY() - outText.getHeight())
                if (scrollDelta > 0)
                   outText.scrollBy(0, scrollDelta)
            }
        }
    }

    // HIDE KEYBOARD FUNCTION
    fun Activity.hideKeyboard()
    {
        hideKeyboard(if (currentFocus == null) View(this) else currentFocus)
    }

    fun Context.hideKeyboard(view: View)
    {
        val inputMethodManager = getSystemService(Activity.INPUT_METHOD_SERVICE) as InputMethodManager
        inputMethodManager.hideSoftInputFromWindow(view.windowToken, 0)
    }

    private fun loadMorseJSONFile() : JSONObject {

        // Loading morse.json from assets folder
        val filePath = "morse.json"

        //String file from assets folder
        val jsonStr = application.assets.open(filePath).bufferedReader().use { it.readText() }

        // Parsing in Kotlin
        val jsonObj = JSONObject(jsonStr.substring(jsonStr.indexOf("{"), jsonStr.lastIndexOf("}") + 1))

        return jsonObj

    }

    // Copying key/value pairs for JSON objects
    private fun buildDictsWithJSON(jsonObj : JSONObject) {
        for ( key in jsonObj.keys() ) {
            val code : String = jsonObj[key] as String

            letToCodeDict.put(key,code)
            codeToLetDict.put(code,key)

            Log.d("log", "$key: $code")

        }
    }

    private fun showCodes() {
        appendTextAndScroll("HERE ARE THE CODES")
        for (key in letToCodeDict.keys.sorted()){
            appendTextAndScroll("${key.toUpperCase()}: ${letToCodeDict[key]}")
        }
    }


    private fun translateText(input : String) : String {

        var value = ""

        val lowerStr = input.toLowerCase()

        for (c in lowerStr) // Loop for checking all the input
        {
            // if space than explode
            if (c == ' ') value += "/ "
            else if (letToCodeDict.containsKey(c.toString())) value += "${letToCodeDict[c.toString()]} "
            else value += "? "
        }

        Log.d("log", "Morse: $value")

        return value

    }

    private fun translateMorse(input: String) : String {
        var value = ""

        val lowerStr = input.split("(\\s)+".toRegex())

        Log.d("log", "Split stirng: $lowerStr")

        for (item in lowerStr) {
            if (item == "/") value += " "
            else if (codeToLetDict.containsKey(item)) value += codeToLetDict[item]
            else value += "[NA]"
        }

        Log.d("log", "Text: $value")

        return value
    }


    //PART 4 - BEEPS
    fun playString(s:String, i: Int = 0) : Unit {
        if (i>s.length-1)
            return;
        var mDelay: Long = 0;

        var thenFun: () -> Unit = { ->
            this@MainActivity.runOnUiThread(java.lang.Runnable {playString(s, i+1)})
        }

        var c = s[i]
        Log.d("Log", "Processing pos: " + i + " char: [" + c + "]")
        if (c=='.')
            playDot(thenFun)
        else if (c=='-')
            playDash(thenFun)
        else if (c=='/')
            pause(6*dotLength, thenFun)
        else if (c==' ')
            pause(2*dotLength, thenFun)
    }

    val dotLength:Int = 50
    val dashLength:Int = dotLength*3

    //val morsePitch = prefs!!.getString("morse_pitch", "550").toInt()
    // Put in oncreate and set these to null.
    val dotSoundBuffer: ShortArray = genSineWaveSoundBuffer(550.0, dotLength) //freq: 550.0
    val dashSoundBuffer:ShortArray = genSineWaveSoundBuffer(550.0, dashLength)

    fun playDash(onDone:()->Unit={}){
        Log.d("DEBUG", "playDash")
        playSoundBuffer(dashSoundBuffer,{->pause(dotLength, onDone)})
    }
    fun playDot(onDone: () -> Unit={}){
        Log.d("DEBUG", "playDot")
        playSoundBuffer(dotSoundBuffer,{ -> pause(dotLength, onDone)})
    }

    fun pause(durationMSec:Int, onDone: () -> Unit={}){
        Log.d("DEBUG", "pause: ${durationMSec}")
        Timer().schedule(timerTask { onDone()  }, durationMSec.toLong())
    }

    private fun genSineWaveSoundBuffer(frequency:Double, durationMSec: Int):ShortArray{
        val duration : Int = Math.round((durationMSec/1000.0) * SAMPLE_RATE).toInt()

        var mSound: Double
        val mBuffer = ShortArray(duration)
        for(i in 0 until duration) {
            mSound= Math.sin(2.0*Math.PI*i.toDouble()/(SAMPLE_RATE/frequency))
            mBuffer[i] = (mSound*java.lang.Short.MAX_VALUE).toShort()
        }
        return mBuffer
    }


    private fun playSoundBuffer (mBuffer: ShortArray, onDone: () -> Unit={ }) {
        var minBufferSize = SAMPLE_RATE / 10
        if (minBufferSize < mBuffer.size) {
            minBufferSize = minBufferSize + minBufferSize *
                    (Math.round(mBuffer.size.toFloat()) / minBufferSize.toFloat()).toInt()
        }

        val nBuffer = ShortArray(minBufferSize)
        for (i in nBuffer.indices) {
            if (i < mBuffer.size)
                nBuffer[i] = mBuffer[i]
            else
                nBuffer[i] = 0
        }

        val mAudioTrack = AudioTrack(AudioManager.STREAM_MUSIC, SAMPLE_RATE,
                AudioFormat.CHANNEL_OUT_MONO, AudioFormat.ENCODING_PCM_16BIT,
                minBufferSize, AudioTrack.MODE_STREAM)

        mAudioTrack.setStereoVolume(AudioTrack.getMaxVolume(), AudioTrack.getMaxVolume())
        mAudioTrack.setNotificationMarkerPosition(mBuffer.size)
        mAudioTrack.setPlaybackPositionUpdateListener(object : AudioTrack.OnPlaybackPositionUpdateListener {
            override fun onPeriodicNotification(track: AudioTrack){}
            override fun onMarkerReached(track: AudioTrack?) {
                Log.d("Log", "Audio track end of file reached...")
                mAudioTrack.stop()
                mAudioTrack.release()
                onDone()
            }
        })
        mAudioTrack.play()
        mAudioTrack.write(nBuffer, 0, minBufferSize)
    }


    //PART 6 - TEXT

    fun doTwilioSend(message: String, toPhoneNum: String){
        // IF YOU HAVE A PUBLIC GIT, DO NOT, DO NOT, PUT YOUR TWILIO SID/TOKENs HERE
        // AND DO NOT CHECK IT INTO GIT!!!
        // Once you check it into a PUBLIC git, it is there for ever and will be stolen.
        // Move them to a JSON file that is in the .gitignore
        // Or make them a user setting, that the user would enter
        // In a real app, move the twilio  parts to a server, so that it cannot be stolen.
        //
        val twilio_account_sid = ""
        val twilio_auth_token = ""
        val fromTwilioNum = ""

        val senderName    = fromTwilioNum  // ??

        val sms = SMS();
        val twilio = Twilio(twilio_account_sid, twilio_auth_token)

        // This code was converted from Java to Kotlin
        //  and then it had to have its parameter types changed before it would work

        sms.sendSMS(twilio, senderName, toPhoneNum, message, object : SMSCallback {
            override fun onResponse(call: okhttp3.Call?, response: Response?) {
                Log.v("twilio", response.toString())
                showSnack(response.toString())
            }
            override fun onFailure(call: okhttp3.Call?, e: java.lang.Exception?) {
                Log.v("twilio", e.toString())
                showSnack(e.toString())
            }
        })
    }

    // helper function to show a quick notice
    fun showSnack(s:String) {
        Snackbar.make(this.findViewById(android.R.id.content), s, Snackbar.LENGTH_LONG)
                .setAction("Action", null).show()
    }

        // ======================================= CUSTOM CODE END =======================================>

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    // ======================================= Settings changed =======================================>
    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        return when (item.itemId) {
            R.id.action_settings->{
                val intent = Intent(this, SettingsActivity::class.java)
                startActivity(intent)
                return true
            }
            //R.id.action_settings -> true
            else -> super.onOptionsItemSelected(item)
        }
    }
}

private operator fun Int.invoke(): Any {
    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
}
