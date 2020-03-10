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
        UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
      }catch(Exception ie){

      }
    frame = (JFrame) ((processing.awt.PSurfaceAWT.SmoothCanvas)app.getSurface().getNative()).getFrame();
    fileDrop fd = new fileDrop(frame);
    frame.setTitle(name);
    frame.setSize(width, height);
    frame.setLocationRelativeTo(null);
    frame.setResizable(true);
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    JMenuBar menu_bar = new JMenuBar();
    frame.setJMenuBar(menu_bar);
    JMenu import_menu = new JMenu("File");

    menu_bar.add(import_menu);

    new_file = new JMenuItem("Import file");
    new_report = new JMenuItem("Generate Report");
    action_exit = new JMenuItem("Exit");

    import_menu.add(new_file);
    import_menu.add(new_report);
    import_menu.addSeparator();
    import_menu.add(action_exit);

    new_report.setEnabled(reportVal);

    new_file.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent arg0) {
        try {
          createFileChooser fc = new createFileChooser("Select text document", "FILES_AND_DIRECTORIES");
          String fileText;
          String entireFileText = new Scanner(new File(fc.getSelection())).useDelimiter("\\A").next();
          String uscanner = entireFileText;
          fileText = uscanner;
          textArea.setText(fileText, 500);
        } catch (Exception ex) {
          System.out.println(ex);
        }
        pubEvent = arg0;
      }
    }
    );
    new_report.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent arg0) {
        getScreen(450, 90, 500, 300); 
        String new_title = "Report_" + year() + "_" + month() + "_" + hour() + "_" + minute();

        documentExport de = new documentExport(docText, styleText, log, new_title);
        pubEvent = arg0;
      }
    }
    );
    action_exit.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent arg0) {
        exit();
        pubEvent = arg0;
      }
    }
    );
    frame.setVisible(true);
  }

  void activateReport(){
    new_report.setEnabled(true);
  }
}