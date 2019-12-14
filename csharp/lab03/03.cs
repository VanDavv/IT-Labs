using System;
using System.IO;
using System.Text;

public class MainClass {
  public static int Main(string[] args) {
    if(args.Length != 1) {
      Console.WriteLine("Please profide output encoding (like \"us-ascii\" or other code page text - see https://docs.microsoft.com/pl-pl/dotnet/api/system.text.encoding?view=netframework-4.8#uwagi)");
      return 1;
    }
    try
    {   // Open the text file using a stream reader.
      using (StreamReader sr = new StreamReader("text.txt"))
      using (StreamWriter outputFile = new StreamWriter("output.txt", false, Encoding.GetEncoding(args[0])))
      {
        outputFile.WriteLine(sr.ReadToEnd());
      }
    }
    catch (IOException e)
    {
      Console.WriteLine("The file could not be read:");
      Console.WriteLine(e.Message);
      return 1;
    }
    catch (ArgumentException e)
    {
      Console.WriteLine("Provided encoding is invalid:");
      Console.WriteLine(e.Message);
      return 1;
    }
    return 0;
  }
}