package com.example.lab01;

import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;

import android.os.Bundle;
import android.text.method.ScrollingMovementMethod;
import android.widget.TextView;

import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ConstraintLayout layout = findViewById(R.id.mainLayout);
        TextView content = findViewById(R.id.textView3);
        TextView source = findViewById(R.id.textView2);

        if ("pol".equals(Locale.getDefault().getISO3Language())) {
            content.setText("Uznawany za jednego z najpopularniejszych aktorów polskiego kina lat 90. Zadebiutował w 1986 w filmie Czarne Stopy rolą druha Pumy. Uznanie widzów i popularność zdobył, występując w filmie Kroll (1991) w reż. Władysława Pasikowskiego, za którą dostał nagrodę za najlepszą drugoplanową rolę męską na 16. Festiwalu Polskich Filmów Fabularnych w Gdyni");
            source.setText("Źródło: http://www.kulturatka.pl/2016/11/28/cezary-pazura-the-best-of-2016/");
        } else {
            content.setText("Recognized as one of the most popular actors of Polish cinema in the 90s. He made his debut in 1986 in the film Black Feet as a companion of Puma. He gained audience recognition and popularity in the film Kroll (1991) dir. Władysław Pasikowski, for which he received an award for the best supporting male role at the 16th Polish Film Festival in Gdynia");
            source.setText("Source: http://www.kulturatka.pl/2016/11/28/cezary-pazura-the-best-of-2016/");
        }

        content.setMovementMethod(new ScrollingMovementMethod());
    }
}
