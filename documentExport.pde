class documentExport{
  	
    PrintWriter output;

    documentExport(String _text, String _style, String _log, String _title){
        String webpage = "<!DOCTYPE html>\n<html>\n<head>\n<title>"+ _title +"</title>"+
        "\n<style>\nhtml{\n"+
        "background: #e3e6ff;\n"+
        "font: bold 18px sans-serif;\n"+
        "}\n"+
        ".container{\n"+
        "border-radius: 5px;\n"+
        "padding: 10px;\n"+
        "margin-bottom: 20px;\n"+
        "background-color: #e3e6ff;\n"+
        "-webkit-box-shadow: 0px 11px 16px 0px rgba(0,0,0,0.28);\n"+
        "-moz-box-shadow: 0px 11px 16px 0px rgba(0,0,0,0.28);\n"+
        "box-shadow: 0px 11px 16px 0px rgba(0,0,0,0.28);\n"+
        "}\n"+
        ".center {\n"+
        "display: block;\n"+
        "margin-left: auto;\n"+
        "margin-right: auto;\n"+
        "}\n"+_style+"</style>\n</head>\n<body>\n"+
        "<div class=\"container\"><table>"+ _text + "</table></div>\n"+
        "<div class=\"container\">\n"+
        "<image class=\"center\" src=\"slice.png\" width=500 height=300/>\n"+
        "</div>\n"+
        "<div class=\"container\">\n"+
        "<span>" + _log + "</span>\n"+
        "</div>\n"+
        "</body>\n"+
        "</html>";
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