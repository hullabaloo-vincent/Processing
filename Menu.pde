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
    JMenu import_menu = new JMenu("Import");
    JMenu text_menu = new JMenu("Run");

    menu_bar.add(import_menu);
    menu_bar.add(text_menu);

    JMenuItem new_file = new JMenuItem("Import file");
    JMenuItem new_folder = new JMenuItem("Import folder");
    JMenuItem action_exit = new JMenuItem("Exit");

    import_menu.add(new_file);
    import_menu.add(new_folder);
    import_menu.addSeparator();
    import_menu.add(action_exit);

    new_file.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent arg0) {
        System.out.println("You have clicked on the new action");
        pubEvent = arg0;
      }
    }
    );
    frame.setVisible(true);
  }
}