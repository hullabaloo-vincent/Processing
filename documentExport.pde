class documentExport{
  	
    PrintWriter output;

    documentExport(String _text, String _title){
        String webpage = "<!DOCTYPE html>\n<html>\n<head>\n<title>"+ _title +"</title>"+
        "\n</head>\n<body>\n"+ _text + "</body></html>";
        String fileName = _title + ".html";
        output = createWriter("data/"+fileName); 
        output.println(webpage); // Write the coordinate to the file
        output.flush(); // Writes the remaining data to the file
        output.close();
        String programDir =  dataPath("");
        programDir = programDir.replace("\\", "/");
        link("file:///" + programDir + "/" + fileName);
    }
}