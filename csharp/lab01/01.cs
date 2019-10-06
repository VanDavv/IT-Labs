using System;
using System.IO;
using System.Text;

/*
Tworzymy w Excelu wiersze i kolumny
3 kolumny, dwa wiersze
format CSV
wyjście: plik html
wejście plik csv

otworzyć plik, wczytać zawartość, umieścić w tagach HTML
*/

public class HelloWorld
{
    public static int Main(string[] args)
    {
        if(args.Length != 2) {
	    Console.WriteLine(string.Format("Invalid number of parameters. Expecting 2, received {0}", args.Length));
	    return 1;
	}
	string source = args[0], destination = args[1];
	Console.WriteLine(string.Format("CSV input: {0}, destination: {1}", source, destination));

	if(!File.Exists(source)) {
	    Console.WriteLine(string.Format("No file found at source location {0}", source));
	    return 1;
	}
	if(File.Exists(destination)) {
	    Console.WriteLine(string.Format("Warning: destination location {0} is not empty, changes will be overwritten...", destination));
	}
	using(var reader = new StreamReader(source))
	using (var fileStream = new FileStream(destination, FileMode.OpenOrCreate))
	using (var streamWriter = new StreamWriter(fileStream))
    	{
	    var wroteHeader = false;
	    streamWriter.WriteLine("<html>\n<body>\n<table>");
            while (!reader.EndOfStream)
            {
            	var line = reader.ReadLine();
            	var values = line.Split(',');
		if(!wroteHeader) {
		    var outputLine = new StringBuilder("<thead>\n<tr>\n");
		    foreach(var value in values)
		    {
		        outputLine.Append(string.Format("<th>{0}</th>\n", value));
		    }
		    outputLine.Append("</tr>\n</thead>\n<tbody>");
		    streamWriter.WriteLine(outputLine);
		    wroteHeader = true;
		} else {
		    var outputLine = new StringBuilder("<tr>\n");
		    foreach(var value in values)
		    {
                        outputLine.Append(string.Format("<th>{0}</th>\n", value));
		    }
		    outputLine.Append("</tr>");
		    streamWriter.WriteLine(outputLine);
		}
            }
	    streamWriter.WriteLine("</tbody>\n</table>\n</body>\n</html>");
    	}
	return 0;
    }
}
