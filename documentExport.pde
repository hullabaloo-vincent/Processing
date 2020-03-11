class documentExport{
  	
    PrintWriter output;

    documentExport(String _text, String _style, String _log, String _title){
        String[] textTest = calc.getArray(calc.pTerms);
        String webpage = "<!DOCTYPE html>\n<html>\n<head>\n<title>"+ _title +"</title>"+
        "\n<style>\nhtml{\n"+
        "   background: #e3e6ff;\n"+
        "   font: bold 18px sans-serif;\n"+
        "}\n"+
        ".container{\n"+
        "   border-radius: 5px;\n"+
        "   padding: 10px;\n"+
        "   margin-bottom: 20px;\n"+
        "   background-color: #e3e6ff;\n"+
        "   -webkit-box-shadow: 0px 11px 16px 0px rgba(0,0,0,0.28);\n"+
        "   -moz-box-shadow: 0px 11px 16px 0px rgba(0,0,0,0.28);\n"+
        "   box-shadow: 0px 11px 16px 0px rgba(0,0,0,0.28);\n"+
        "}\n"+
        ".center {\n"+
        "   display: block;\n"+
        "   margin-left: auto;\n"+
        "   margin-right: auto;\n"+
        "}\n"+
        ".nav {\n"+
        "   z-index: 100 !important;\n"+
        "   display: block;\n"+
        "   position: relative;\n"+
        "   width: 100%;\n"+
        "    box-shadow: 0 4px 2px -2px rgba(0, 0, 0, 0.1), 0 4px 2px -2px rgba(0, 0, 0, 0.19);\n"+
        "}\n"+
        ".nav ul {\n"+
        "    z-index: 100;\n"+
        "    list-style-type: none;\n"+
        "    margin: 0;\n"+
        "    padding: 0;\n"+
        "    overflow: hidden;\n"+
        "    background-color: rgb(227, 230, 255);\n"+
        "}\n"+
        "@supports (backdrop-filter: blur(10px)) {\n"+
        "   .nav ul {\n"+
        "        background-color: rgba(227, 230, 255, 0.75);\n"+
        "        backdrop-filter: blur(10px);\n"+
        "   }\n"+
        "}\n"+
        ".nav li {\n"+
        "z-index: 100;\n"+
        "float: left;\n"+
        "}\n"+
        ".nav li a {\n"+
        "   z-index: 100;\n"+
        "   display: block;\n"+
        "   color: #2c1752;\n"+
        "   text-align: center;\n"+
        "   padding: 15px 15px;\n"+
        "   text-decoration: none;\n"+
        "}\n"+
        ".nav li a:hover:not(.active) {\n"+
        "   z-index: 100;\n"+
        "   background-color: #8376ff;\n"+
        "   color: white;\n"+
        "}\n"+
        ".nav li a.active {\n"+
        "   z-index: 100;\n"+
        "   color: white;\n"+
        "   background-color: #8376ff;\n"+
        "}\n"+
        ".sticky {\n"+
        "   position: fixed;\n"+
        "   width: 100%;\n"+
        "   left: 0;\n"+
        "   top: 0;\n"+
        "   z-index: 100;\n"+
        "   border-top: 0;\n"+
        "}\n"+
        "#myBtn {\n"+
        "   display: none;\n"+
        "   position: fixed;\n"+
        "   bottom: 20px;\n"+
        "   right: 30px;\n"+
        "   z-index: 99;\n"+
        "   font-size: 18px;\n"+
        "   border: none;\n"+
        "   outline: none;\n"+
        "   background-color: #e3e6ff;\n"+
        "   color: #2c1752;\n"+
        "   cursor: pointer;\n"+
        "   padding: 15px;\n"+
        "   width: 50px !important;\n"+
        "   border-radius: 100px !important;\n"+
        "   box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.1), 0 1px 4px 0 rgba(0, 0, 0, 0.19);\n"+
        "   text-decoration: none !important;\n"+
        "}\n"+
        "#myBtn:hover {\n"+
        "    background-color: #8376ff;\n"+
        "   color: white;\n"+
        "}\n"+_style+"</style>\n"+
        "<script src=\"https://code.jquery.com/jquery-3.4.0.slim.min.js\" integrity=\"sha256-ZaXnYkHGqIhqTbJ6MB4l9Frs/r7U4jlx7ir8PJYBqbI=\" crossorigin=\"anonymous\"></script>\n"+
        "<script defer src=\"https://use.fontawesome.com/releases/v5.8.1/js/all.js\" integrity=\"sha384-g5uSoOSBd7KkhAMlnQILrecXvzst9TdC09/VM+pjDTCM+1il8RHz5fKANTFFb+gQ\" crossorigin=\"anonymous\"></script>\n"+
        "<script>\n"+
        "$(document).ready(function () {\n"+
        "var stickyNavTop = $('.nav').offset().top;\n"+
        "var stickyNav = function () {\n"+
        "   var scrollTop = $(window).scrollTop();\n"+
        "   if (scrollTop > stickyNavTop) {\n"+
        "       $('.nav').addClass('sticky');\n"+
        "       $('.nav2').addClass('sticky_sub');\n"+
        "   } else {\n"+
        "       $('.nav').removeClass('sticky');\n"+
        "       $('.nav2').removeClass('sticky_sub');\n"+
        "   }\n"+
        "};\n"+
    "stickyNav();\n"+
    "$(window).scroll(function () {\n"+
    "    stickyNav();\n"+
    "});\n"+
    "});\n"+
    "window.onscroll = function () {\n"+
    "    scrollFunction()\n"+
    "};\n"+
    "function scrollFunction() {\n"+
    "    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 40) {\n"+
    "        document.getElementById(\"myBtn\").style.display = \"block\";\n"+
    "} else {\n"+
    "    document.getElementById(\"myBtn\").style.display = \"none\";\n"+
    "}\n"+
    "}\n"+
    "function topFunction() {\n"+
    "    document.body.scrollTop = 0;\n"+
    "   document.documentElement.scrollTop = 0;\n"+
    "}\n"+
    "</script>\n"+
        "</head>\n<body>\n"+
        "<button onclick=\"topFunction()\" id=\"myBtn\" title=\"Go to top\"><i class=\"fas fa-chevron-up\"></i></button>\n"+
        "<div class=\"nav\">\n"+
        "   <ul>\n"+
        "       <li><a href=\"#sentences\">Sentences</a></li>\n"+
        "       <li><a href=\"#scale\">Scale</a></li>\n"+
        "       <li><a href=\"#wordBank\">Word Bank</a></li>\n"+
        "   </ul>\n"+
        "</div>\n"+
        "<div class=\"container\" id=\"sentences\"><table>"+ _text + "</table></div>\n"+
        "<div class=\"container\">\n"+
        "   <image class=\"center\" id=\"scale\" src=\"slice.png\" width=500 height=256/>\n"+
        "</div>\n"+
        "<div class=\"container\" id=\"wordBank\">\n"+
        "<span align=\"center\"> Comparative Adverb: " + calc.compAdv + "</span><br />\n"+
        "<span align=\"center\"> Comparative Ajective " + calc.compAdj + "</span><br />\n"+
        "<span align=\"center\"> Adverb: " + calc.advb + "</span><br />\n"+
        "<span align=\"center\"> Adjective: " + calc.adj + "</span><br />\n"+
        "<span align=\"center\"> Interjection: " + calc.interj + "</span><br />\n"+
        "<span align=\"center\"> Verb: " + calc.vb + "</span><br />\n"+
        "<span align=\"center\"> Verb 3rd Person: " + calc.vb3rd + "</span><br />\n"+
        "<span align=\"center\"> Verb Gerund: " + calc.vbg + "</span><br />\n"+
        "<span align=\"center\"> Common Noun: " + calc.cNoun + "</span><br />\n"+
        "<span align=\"center\"> ____________________________________________</span><br />\n"+
        "<span align=\"center\"> Word Bank </span><br />\n"+
        "<span> " + Arrays.toString(textTest) + "</span>\n"+
        "</div>\n"+
        "</body>\n"+
        "</html>";
        String fileName = _title + ".html";
        output = createWriter("data/"+fileName); 
        output.println(webpage); //write the data to the file
        output.flush(); //writes the remaining data to the file
        output.close(); //closes writer
        String programDir =  dataPath(""); //get absolute path of data folder
        programDir = programDir.replace("\\", "/"); //replace backward slashes to forward slashes
        link("file:///" + programDir + "/" + fileName); //open webpage in default browser
    }
}