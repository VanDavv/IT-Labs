package com.example.lab01;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import java.util.Locale;

public class Main3Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);
        EditText weight = findViewById(R.id.editText);
        EditText height = findViewById(R.id.editText2);
        Button button = findViewById(R.id.button);

        if ("pol".equals(Locale.getDefault().getISO3Language())) {
            weight.setHint("Waga");
            height.setHint("Wzrost");
            button.setText("Oblicz BMI");
        } else {
            weight.setHint("Weight");
            height.setHint("Height");
            button.setText("Calculate BMI");
        }
    }

    /** Called when the user taps the Send button */
    public void submit(View view) {
        EditText weightView = findViewById(R.id.editText);
        EditText heightView = findViewById(R.id.editText2);

        double weight = Double.parseDouble(weightView.getText().toString());
        double height = Double.parseDouble(heightView.getText().toString()) / 100;

        double result = weight / (height * height);

        Intent returnIntent = new Intent();
        returnIntent.putExtra("result", String.format("%.2f", result));
        setResult(Activity.RESULT_OK,returnIntent);
        finish();
    }
}
