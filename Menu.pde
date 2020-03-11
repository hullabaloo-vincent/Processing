import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import java.io.IOException;

public class Menu {
  JFrame frame;
  ActionEvent pubEvent;
  boolean reportVal = false;
  JMenuItem new_file;
  JMenuItem new_report;
  JMenuItem action_exit;

  public Menu(PApplet app, String name, int width, int height){
      try{
        UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); //set look and feel of Java GUI to system default
      }catch(Exception ie){
        System.out.println(ie);
      }
    frame = (JFrame) ((processing.awt.PSurfaceAWT.SmoothCanvas)app.getSurface().getNative()).getFrame(); //wrape JFrame around PApplet
    fileDrop fd = new fileDrop(frame); //add file dropping ability to JFrame
    frame.setTitle(name); //set title of program
    frame.setSize(width, height); //set program width and height
    frame.setLocationRelativeTo(null); //load program in the middle of screen
    frame.setResizable(true); //allow window to be resized by user (required by PSurfaceAWT or program won't functino)
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); //set default close operation

    JMenuBar menu_bar = new JMenuBar(); //create menubar
    frame.setJMenuBar(menu_bar); //set menubar to JFrame

    JMenu import_menu = new JMenu("File"); //create JMenu

    menu_bar.add(import_menu); //add JMenu to menubar

    /* Init JMenuItems */
    new_file = new JMenuItem("Import file"); //import file button. Opens JFileChooser
    new_report = new JMenuItem("Generate Report"); //Generates html report
    action_exit = new JMenuItem("Exit"); //exits program

    /* Adds JMenuItems to JMenu */
    import_menu.add(new_file);
    import_menu.add(new_report);
    import_menu.addSeparator();
    import_menu.add(action_exit);

    new_report.setEnabled(reportVal); //disables genearate report button

    /*----------------------------------------*/
    /* Import new file button action listener */
    new_file.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent arg0) {
        try {
          createFileChooser fc = new createFileChooser("Select text document", "FILES_AND_DIRECTORIES"); //creates file chooser
          String fileText;
          String entireFileText = new Scanner(new File(fc.getSelection())).useDelimiter("\\A").next(); //parses content of file
          String uscanner = entireFileText;
          fileText = uscanner;
          textArea.setText(fileText, 500); //set user text area to the selected file contents
        } catch (Exception ex) {
          System.out.println(ex);
        }
        pubEvent = arg0;
      }
    }
    );
    /*----------------------------------------*/

    /*----------------------------------------*/
    /* Generate report button action listener */
    new_report.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent arg0) {
        getScreen(450, 90, 500, 256); //take selection of screen to include sentiment visualizer
        String new_title = "Report_" + year() + "_" + month() + "_" + hour() + "_" + minute(); //gets time of day

        documentExport de = new documentExport(docText, styleText, log, new_title); //generate html document
        pubEvent = arg0;
      }
    }
    );
    /*----------------------------------------*/

    /*----------------------------------------*/
    /* Exit button action listener */
    action_exit.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent arg0) {
        exit(); //exits program
        pubEvent = arg0;
      }
    }
    );
    frame.setVisible(true);
  }
  /*----------------------------------------*/

  /*----------------------------------------*/
  /* Enable 'Generate Report' button */
  void activateReport(){
    new_report.setEnabled(true);
  }
  /*----------------------------------------*/
}