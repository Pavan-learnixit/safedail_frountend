package com.example.truecaller_clone;

import android.os.Build;
import android.telecom.Call;
import android.telecom.CallScreeningService;
import android.util.Log;
import android.content.Intent;

import androidx.annotation.RequiresApi;

@RequiresApi(api = Build.VERSION_CODES.N)
public class CallScreeningServiceImpl extends CallScreeningService {
    @Override
    public void onScreenCall(Call.Details callDetails) {
        String phoneNumber = callDetails.getHandle() != null ?
                callDetails.getHandle().getSchemeSpecificPart() : "Unknown";

        Log.d("CallScreening", "Screening call from: " + phoneNumber);

        // Show popup immediately when call is detected
        showCallPopup("Detected call from: " + phoneNumber);

        // Allow the call to proceed
        respondToCall(callDetails, new CallResponse.Builder()
                .setDisallowCall(false)
                .setRejectCall(false)
                .build());
    }

    private void showCallPopup(String message) {
        Intent overlayIntent = new Intent(this, CallOverlayService.class);
        overlayIntent.putExtra("CALLER_INFO", message);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(overlayIntent);
        } else {
            startService(overlayIntent);
        }
    }
}